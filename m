Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0042463D5
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHQJzk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 05:55:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgHQJzj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 05:55:39 -0400
Received: from zn.tnic (p200300ec2f26be0071e1cf3fa1f5ba15.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:71e1:cf3f:a1f5:ba15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 948751EC026E;
        Mon, 17 Aug 2020 11:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597658138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Tf7YYM5n7xeCYKiahGC5yoyixvXsbkIQzXgCUnTbvE=;
        b=qnNWe2+JAHspKFI14qcip1FWrnCyPmEUGlBZmVgUM2uJrggwdS4T4WpaFfKXzqSI+haJoQ
        C6jfNP7Htugt7Yv06dWRXQIUragD1VcI/zFvxGUh5UQ4jJPFucZlwXgoEbP/I7gUlq4CUQ
        7i+CXzsXrc+1zXmEc50vz2mIzGPOxBI=
Date:   Mon, 17 Aug 2020 11:56:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: edac: socfpga: transfer SoCFPGA EDAC
 maintainership
Message-ID: <20200817095638.GE549@zn.tnic>
References: <20200729174511.4256-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729174511.4256-1-dinguyen@kernel.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 29, 2020 at 12:45:11PM -0500, Dinh Nguyen wrote:
> Thor Thayer is leaving Intel and will no longer be able to maintain the
> EDAC for SoCFPGA, thus transfer maintainership to Dinh Nguyen.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0569cf304ca..c53fc9febf12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2466,7 +2466,7 @@ S:	Maintained
>  F:	drivers/clk/socfpga/
>  
>  ARM/SOCFPGA EDAC SUPPORT
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Dinh Nguyen <dinguyen@kernel.org>
>  S:	Maintained
>  F:	drivers/edac/altera_edac.

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
