Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF5245273
	for <lists+linux-edac@lfdr.de>; Sat, 15 Aug 2020 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgHOVvZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgHOVvK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:51:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7AC03B3E7;
        Sat, 15 Aug 2020 02:32:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c7a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:7a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A29941EC0411;
        Sat, 15 Aug 2020 11:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597483956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DVkFmgVppcUdysdhmCgRYqE3/zJKAH13Ppg3uAvwVP8=;
        b=FOb5lXu7Kn7iS2NabxxkPOxoDuF/xer2Qu77aiDAYxskjdo45klK3RVJaZ0IF/ic4gaKoN
        Grp08fbd9Jmd9ZWZk69bruMIgP72l56Pi5EiNwnsDXKMyaQbCipo+ZQVuPqjJFQR17MtQ+
        qhuxBZcCdDOclWH+NnhAd6ZlXjsIHbs=
Date:   Sat, 15 Aug 2020 11:33:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Kluver <alex.kluver@hpe.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, mchehab@kernel.org, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com
Subject: Re: [PATCH] edac,ghes,cper: Add Row Extension to Memory Error Record
Message-ID: <20200815093332.GD25814@zn.tnic>
References: <20200727181445.111002-1-alex.kluver@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727181445.111002-1-alex.kluver@hpe.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 27, 2020 at 01:14:45PM -0500, Alex Kluver wrote:
> Memory errors could be printed with incorrect row values since the DIMM
> size has outgrown the 16 bit row field in the CPER structure. UEFI
> Specification Version 2.8 has increased the size of row by allowing it to
> use the first 2 bits from a previously reserved space within the structure.
> 
> When needed, add the extension bits to the row value printed.
> 
> Based on UEFI 2.8 Table 299. Memory Error Record
> 
> Tested-by: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
> ---
>  drivers/edac/ghes_edac.c    | 10 ++++++++--
>  drivers/firmware/efi/cper.c | 11 +++++++++--
>  include/linux/cper.h        |  9 +++++++--
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index cb3dab56a875..cfa3156300f5 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -337,8 +337,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  		p += sprintf(p, "rank:%d ", mem_err->rank);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
>  		p += sprintf(p, "bank:%d ", mem_err->bank);
> -	if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
> -		p += sprintf(p, "row:%d ", mem_err->row);
> +	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
> +		u32 row_extended = 0;
> +		if (mem_err->validation_bits & CPER_MEM_VALID_ROW_EXT)
> +			row_extended = (mem_err->extended & CPER_MEM_EXT_ROW_MASK)
> +				<<CPER_MEM_EXT_ROW_SHIFT;
> +		row_extended |= mem_err->row;
> +		p += sprintf(p, "row:%d ", row_extended);
> +	}
>  	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
>  		p += sprintf(p, "col:%d ", mem_err->column);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index f564e15fbc7e..5faaf6ecd659 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -234,8 +234,14 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>  		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
>  	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
>  		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
> -	if (mem->validation_bits & CPER_MEM_VALID_ROW)
> -		n += scnprintf(msg + n, len - n, "row: %d ", mem->row);
> +	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
> +		u32 row_extended = 0;
> +		if (mem->validation_bits & CPER_MEM_VALID_ROW_EXT)
> +			row_extended = (mem->extended & CPER_MEM_EXT_ROW_MASK)
> +				<<CPER_MEM_EXT_ROW_SHIFT;

This is not very readable.

> +		row_extended |= mem->row;
> +		n += scnprintf(msg + n, len - n, "row: %d ", row_extended);
> +	}

Both those hunks contain duplicated code which kinda wants to be an
inline function in cper.h which returns row_extended and gets called by
both sites. And then the call site can look very simple:

        if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
                row = mem_err->row;

        /* add row extension */
        row |= cper_get_mem_extension();

        p += sprintf(p, "row:%d ", row);

with

static inline u32 cper_get_mem_extension(void)
{
	if (!(mem_err->validation_bits & CPER_MEM_VALID_ROW_EXT))
		return 0;

	return (mem_err->extended & CPER_MEM_EXT_ROW_MASK) << CPER_MEM_EXT_ROW_SHIFT;
}

Something along those lines...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
