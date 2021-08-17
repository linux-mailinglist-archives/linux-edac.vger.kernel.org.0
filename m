Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A758A3EEB3B
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhHQKvJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 06:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhHQKvI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Aug 2021 06:51:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4BC061764
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 03:50:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFwfn-0008J5-Rp; Tue, 17 Aug 2021 12:50:23 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mFwfn-0000qd-0p; Tue, 17 Aug 2021 12:50:23 +0200
Message-ID: <0f5ae210aab8ef5e00172928c341c0e6c88790a2.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] MAINTAINERS: EDAC/armada_xp: include dt-bindings
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 17 Aug 2021 12:50:22 +0200
In-Reply-To: <20210817093807.59531-2-krzysztof.kozlowski@canonical.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
         <20210817093807.59531-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2021-08-17 at 11:38 +0200, Krzysztof Kozlowski wrote:
> Include dt-bindings for Marvell Armada XP SDRAM and L2 cache ECC in the
> EDAC-ARMADA entry.

The L2 cache binding is already described in
Documentation/devicetree/bindings/arm/l2c2x0.yaml, so this is only for the
SDRAM.

Jan

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be8e4af8ed64..ec75414db0ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6574,6 +6574,7 @@ EDAC-ARMADA
>  M:	Jan Luebbe <jlu@pengutronix.de>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>  F:	drivers/edac/armada_xp_*
>  
>  EDAC-AST2500

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

