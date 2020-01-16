Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE17113FF05
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 00:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgAPXjy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 18:39:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391259AbgAPXjx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jan 2020 18:39:53 -0500
Received: from zn.tnic (p200300EC2F0B23005181490C10C27842.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:5181:490c:10c2:7842])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 604831EC0391;
        Fri, 17 Jan 2020 00:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579217991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XdVmCwBwt//oBCkhqjb8tTmVc8IASboW33NxVb/IAfY=;
        b=YPQzpgi+jN4kZUdorP3ZJjH+er8RY33Mgz3mEO1/YW2ZWPSDNgpTJlvsWjrCMAitTl9XT/
        S0Sq0petU47LCGnEwBKNo3nt10UVJmhSlpFpqCG/VG6kxtes4xbGlY6i3y5+6I8hMtx03k
        7U+lqdV/g+LomdBjPT+bN37wjTKpVAY=
Date:   Fri, 17 Jan 2020 00:39:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20200116233939.GI27148@zn.tnic>
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 15, 2020 at 06:32:27AM -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>

So for this patch, v2 had Rui Zhao as an author:

https://lkml.kernel.org/r/BN7PR08MB5572B3388B2D7DC8F6C7F285AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com

v3 got Lei as an author:

https://lkml.kernel.org/r/CY1PR0401MB1244062C1738B09D6100F202860A0@CY1PR0401MB1244.namprd04.prod.outlook.com

and now it is you.

So when you send next time, think about who's going to be the author.

> +     line numbers. The valid interrupt names are the followings:

WARNING: 'followings' may be misspelled - perhaps 'following'?
#51: FILE: Documentation/devicetree/bindings/edac/arm-dmc520.txt:10:
+     line numbers. The valid interrupt names are the followings:

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

Also, this patch throws this other checkpatch warning:

WARNING: DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst

but since Rob reviewed it, I'm going to assume checkpatch is wrong here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
