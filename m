Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A02551BC
	for <lists+linux-edac@lfdr.de>; Fri, 28 Aug 2020 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0Xvp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 19:51:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:55723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0Xvo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 19:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598572269;
        bh=1hiWDO5qubwA61FDSyJLXx84okVXi/UAVFmPbOBlmOg=;
        h=X-UI-Sender-Class:From:To:cc:In-reply-to:Subject:Reply-to:
         References:Date;
        b=VMBJqAq3VviAAC0yx1CH/97N8NsothXRmDv7liTEpb1AIbffSKToNhPGIzrYBD+Yq
         b/LsfQpg3Zw0srQA5/ltxe7AQuexzAOm/ZTmIdA0MXuXi40AZFEgQl+79VQyAKAXW1
         9vQ9MWDRmhKQRqihF/Pz1Ox3TTjrbrM1L9TxdBtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.43]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIMfW-1kPn8i3Lb2-00EPgL; Fri, 28 Aug 2020 01:51:09 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id BC4D489976B; Thu, 27 Aug 2020 16:49:36 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
cc:     Stefan Schaeckeler <sschaeck@cisco.com>
In-reply-to: <20200827070743.26628-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] EDAC/aspeed: Fix handling of platform_get_irq() error
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
References: <20200827070743.26628-1-krzk@kernel.org> <0D9EC2D2-C4A0-42E9-94A5-DCFBE7BFEC43@cisco.com>
Message-Id: <20200827234936.BC4D489976B@corona.crabdance.com>
Date:   Thu, 27 Aug 2020 16:49:36 -0700 (PDT)
X-Provags-ID: V03:K1:azkzLvPntcmTm1iQW+tTZY0j0Bw8xT/ONekQtE1unQJo5A5nksM
 0GJNUHDntBKfW9JMgtHXOgakjgRZ9d8RwKK3LuJjW2SrBGuCcwnSAijTG0S5i8xcdnLb5zj
 7F5iRtWFoR1v5GeCwmcM5Xh0GLc1mrCjBLQ6OeRXvWaOIQY+5FyMcDI9fcDSpCObJWsjAO7
 obEjJZR8JDf3it+0pJQ6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/OvK2bbtTU=:A09178/DvDkjQ5H05FibnD
 w89W/+z13Q99JCy4Ml5fyIGmz6t/4vxovxGjIOiqURouD4X904XZFzBuuVF0CV4OWQ4uJSgfr
 Js+n1fj7mVcuLue4jQSAMLb6N69qQZqxdmSWkx/hV8o0iQxXUio5Z6cegwcjFeWinE2OY+6rI
 B+qUlw05W8TMComuqhTCxqZEJL8HrSD8vfpUVJHnCabVutzE3jFdU200pqISU4L2ORyccOabu
 RxZfbAjBCvcDDVTy/g2JslmNk3gtB53yvd3hDMWAk1iSJ3KG9trmBl1jFyii4mbWTf5F+TDty
 njlUn/VNgvwj7ppm3F4Vw/t4jdJ1/E9eXdONXlU5fNs7nzqEvrn1GFO5Rkuqi0+mHVGoYXtct
 aI8iyVe8Dn1Qmou+mrFOAkM0XDF6ABgBaeCFjLEXD2N6yMSpa7ePXniaBqeWy5AUccEI7JKcH
 GZY3opRgRTY3jO9+0sNnYuqa+9tuHOtvIQ53lYlnyMK0jw7zEiofOlb9+pVPXpsYBTiLfrGEy
 NTNe/lHISwWf4OfgUGjtAuEEsiiSnePK0KmvQUcR8i9+oExuPhV15FkWBwi5zeZa2sBEZNvjt
 63bh/4ZG+Z12iwYMVso2kTjZnVjQdPOoHS6d1LXJIaTKsQoWIyuxBXvrpJn2tNOWHblzMAMDZ
 08l5eSRnp/R8CNslezuov1V0FZunXPchhwm2uKcXckI06JhR35UBh1WLm5UMk3qnoSnpqFYTo
 Ji7GiaKfqWi9XwR0P/LaamAKarTwmMfh77FPCWOJNXqF/rJ08Ajv+JXjSh+P4oGEfk40omAhN
 27ql56g92KkrNLP931ubVKTBycYcqTt/5HB03FzHmhe0LYAhwt502BC1okkh43P1Kl+O28iov
 IM9TOr/vghrLit69KdYymJ3AwhDFSmjhnPKgQpOZygZV0bgqX/pOUzqhs+Rf/MpSFxdO2fbFs
 qLaMGJpuMHFAmdiPP6w+vfsCgWLMpoK+IVP9GoGmMrUjm0xhNFsNcSKkbQY8KUsG/vn6DaZWd
 VDRf/aemmpa//UZDsz2DsA9CCoC/cPGlmpDRXzWPsp6IfxbHtaTjBr/V3BPn22WTTib//KFSU
 qY2ob2LBo17tNL/KV92Ik3P+ij8EI1d0SsgLk0nedifs6pzgvkxAWE9eoQrcYvD7mSSQGnqyx
 v7M2CaPngEQM4YgJ2FDmxC5NsUYyG9G4HO8lai/fgAY0VBbhbrz3eb4xvFg/e12PoLKI+mlxv
 4GADs/DrbXDGv+UgFJYASi5eaarLEJNIGhbplkA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>  platform_get_irq() returns -ERRNO on error.  In such case comparison
>  to 0 would pass the check.
>
>  Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
>  Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Stefan Schaeckeler <schaecsn@gmx.net>

>  ---
>  drivers/edac/aspeed_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>  diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
>  index b194658b8b5c..fbec28dc661d 100644
>  --- a/drivers/edac/aspeed_edac.c
>  +++ b/drivers/edac/aspeed_edac.c
>  @@ -209,8 +209,8 @@ static int config_irq(void *ctx, struct platform_de=
vice *pdev)
>   	/* register interrupt handler */
>   	irq =3D platform_get_irq(pdev, 0);
>   	dev_dbg(&pdev->dev, "got irq %d\n", irq);
>  -	if (!irq)
>  -		return -ENODEV;
>  +	if (irq < 0)
>  +		return irq;
>
>   	rc =3D devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
>   			      DRV_NAME, ctx);
>  --
>  2.17.1
>
>
