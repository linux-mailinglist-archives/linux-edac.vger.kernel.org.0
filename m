Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6B244509
	for <lists+linux-edac@lfdr.de>; Fri, 14 Aug 2020 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgHNGd5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Aug 2020 02:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNGd5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Aug 2020 02:33:57 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1742177B;
        Fri, 14 Aug 2020 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597386836;
        bh=szZVAba7Oq2urndYZFVNoJlOG9FToXK2RKzK7uibqWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zsSyY/P+ITjhGuDeJwHufz9L96uH/2992vz1r0+NgX5ZnxsIQAkGGFcPOBxyrZa1S
         55VOwt67P4v3JJfoWYZQvTNuhysvuYp9Gs3krEg61GnMacBmR3Cznx/bcEqMmj2D6U
         xD96a2sgFGj1f4La4B6AF3oadOuq0mkSTeJOqTUY=
Received: by mail-oi1-f170.google.com with SMTP id h3so7280801oie.11;
        Thu, 13 Aug 2020 23:33:55 -0700 (PDT)
X-Gm-Message-State: AOAM5331GdxWprbfEFjwQMGWZYh3/jkui+aTIVoEbrcx7ryxCePqWzW3
        g/U9Ck7W2d/LEwyMYcnyoNR9QpNuEH86xIx7TVc=
X-Google-Smtp-Source: ABdhPJz/fvSohK7N7lGNcLlz41tAlbnCFYoufNW9lNS3Xjm8ipo4hwja7N+I5i2hiJRdru3XqqBpkh8SkUwtfz6u03Y=
X-Received: by 2002:a05:6808:b:: with SMTP id u11mr685223oic.33.1597386835187;
 Thu, 13 Aug 2020 23:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200727181445.111002-1-alex.kluver@hpe.com>
In-Reply-To: <20200727181445.111002-1-alex.kluver@hpe.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Aug 2020 08:33:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHtz5wvKCmJwQ_Q8sn43bHtEq0BmMc6AndswOnt1_CG6Q@mail.gmail.com>
Message-ID: <CAMj1kXHtz5wvKCmJwQ_Q8sn43bHtEq0BmMc6AndswOnt1_CG6Q@mail.gmail.com>
Subject: Re: [PATCH] edac,ghes,cper: Add Row Extension to Memory Error Record
To:     Alex Kluver <alex.kluver@hpe.com>
Cc:     linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mchehab@kernel.org, russ.anderson@hpe.com,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 27 Jul 2020 at 20:15, Alex Kluver <alex.kluver@hpe.com> wrote:
>
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

Unless any of the EDAC folks object, I will take this as a fix via the EFI tree.

Thanks,
Ard.


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index cb3dab56a875..cfa3156300f5 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -337,8 +337,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>                 p += sprintf(p, "rank:%d ", mem_err->rank);
>         if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
>                 p += sprintf(p, "bank:%d ", mem_err->bank);
> -       if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
> -               p += sprintf(p, "row:%d ", mem_err->row);
> +       if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
> +               u32 row_extended = 0;
> +               if (mem_err->validation_bits & CPER_MEM_VALID_ROW_EXT)
> +                       row_extended = (mem_err->extended & CPER_MEM_EXT_ROW_MASK)
> +                               <<CPER_MEM_EXT_ROW_SHIFT;
> +               row_extended |= mem_err->row;
> +               p += sprintf(p, "row:%d ", row_extended);
> +       }
>         if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
>                 p += sprintf(p, "col:%d ", mem_err->column);
>         if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index f564e15fbc7e..5faaf6ecd659 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -234,8 +234,14 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
>                 n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
>         if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
>                 n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
> -       if (mem->validation_bits & CPER_MEM_VALID_ROW)
> -               n += scnprintf(msg + n, len - n, "row: %d ", mem->row);
> +       if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
> +               u32 row_extended = 0;
> +               if (mem->validation_bits & CPER_MEM_VALID_ROW_EXT)
> +                       row_extended = (mem->extended & CPER_MEM_EXT_ROW_MASK)
> +                               <<CPER_MEM_EXT_ROW_SHIFT;
> +               row_extended |= mem->row;
> +               n += scnprintf(msg + n, len - n, "row: %d ", row_extended);
> +       }
>         if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
>                 n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
>         if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
> @@ -292,6 +298,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
>         cmem->requestor_id = mem->requestor_id;
>         cmem->responder_id = mem->responder_id;
>         cmem->target_id = mem->target_id;
> +       cmem->extended = mem->extended;
>         cmem->rank = mem->rank;
>         cmem->mem_array_handle = mem->mem_array_handle;
>         cmem->mem_dev_handle = mem->mem_dev_handle;
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 8537e9282a65..c8313753ee49 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -230,6 +230,10 @@ enum {
>  #define CPER_MEM_VALID_RANK_NUMBER             0x8000
>  #define CPER_MEM_VALID_CARD_HANDLE             0x10000
>  #define CPER_MEM_VALID_MODULE_HANDLE           0x20000
> +#define CPER_MEM_VALID_ROW_EXT                 0x40000
> +
> +#define CPER_MEM_EXT_ROW_MASK                  0x3
> +#define CPER_MEM_EXT_ROW_SHIFT                 16
>
>  #define CPER_PCIE_VALID_PORT_TYPE              0x0001
>  #define CPER_PCIE_VALID_VERSION                        0x0002
> @@ -443,7 +447,7 @@ struct cper_sec_mem_err_old {
>         u8      error_type;
>  };
>
> -/* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
> +/* Memory Error Section (UEFI >= v2.3), UEFI v2.8 sec N.2.5 */
>  struct cper_sec_mem_err {
>         u64     validation_bits;
>         u64     error_status;
> @@ -461,7 +465,7 @@ struct cper_sec_mem_err {
>         u64     responder_id;
>         u64     target_id;
>         u8      error_type;
> -       u8      reserved;
> +       u8      extended;
>         u16     rank;
>         u16     mem_array_handle;       /* "card handle" in UEFI 2.4 */
>         u16     mem_dev_handle;         /* "module handle" in UEFI 2.4 */
> @@ -483,6 +487,7 @@ struct cper_mem_err_compact {
>         u16     rank;
>         u16     mem_array_handle;
>         u16     mem_dev_handle;
> +       u8      extended;
>  };
>
>  /* PCI Express Error Section, UEFI v2.7 sec N.2.7 */
