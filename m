Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3351173D8
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2019 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLISPB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 13:15:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfLISO7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Dec 2019 13:14:59 -0500
Received: from zn.tnic (p200300EC2F07FE0004E849530B6CB65A.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:fe00:4e8:4953:b6c:b65a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF58A1EC0C1A;
        Mon,  9 Dec 2019 19:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575915297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+9J74HXPXpQjfbF2S3fh6rnuCytPtwdJt13WO1twBN0=;
        b=NHTs/w8MEJOPRg50hPLzRPJTUTyg8r9wTHsIhelmre51ttoi7UDpI5XVbfKZdfr/zborta
        6t6DQc6qA5iMtOUm0CcRqMCjPJ6Z2MqtgdmwoPuEijlMSoEnmCr3lmCUvPfMCBbDNECxrJ
        Myn+YN+7suQjtFv3veVaKSEy9IRTYo8=
Date:   Mon, 9 Dec 2019 19:14:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] edac: Fix Kconfig indentation
Message-ID: <20191209181449.GB32641@zn.tnic>
References: <20191120134206.15588-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120134206.15588-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 20, 2019 at 09:42:06PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/edac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 417dad635526..c49f6bc39716 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -492,7 +492,7 @@ config EDAC_TI
>  	depends on ARCH_KEYSTONE || SOC_DRA7XX
>  	help
>  	  Support for error detection and correction on the
> -          TI SoCs.
> +	  TI SoCs.
>  
>  config EDAC_QCOM
>  	tristate "QCOM EDAC Controller"
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
