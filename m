Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1574128E137
	for <lists+linux-edac@lfdr.de>; Wed, 14 Oct 2020 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgJNNZO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Oct 2020 09:25:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43820 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgJNNZO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Oct 2020 09:25:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id l85so3171031oih.10;
        Wed, 14 Oct 2020 06:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJpUSFln9JOiWZwDX83Xde5QvOGmiJAsY3aNUB7yL/8=;
        b=Jrkpz1ZvObCrwgnW592a5LzSp7cCTCLDhGJBrenC8D0f+pWsWjDlgN6TH7uJ/Zt+cM
         UFBXccE6PFqC5cbzW3G3U3wueYwqevMYYczSc5NHkvPWj31Jo/SN8vM1B+rmJU135vNf
         Ymx191z7irylDKm3jECjrK7cMccXbOJlcd5Cc+zBv0Xeo9rpaN0Rpgd90nCAK7GbTrO6
         F/mADPt0zAZFOEqT9uzZyZH7jMkoZKNBaIDhoLCubBtm0KPPiX9QdQNvVUzVr0GVsEid
         BfDpxFDgA3CTTT2oZ/uo1t1QFhZZa9UTNxjk2WSSbReUw3dJaTU6w3MnnawsO0ZyZnQ4
         sgFA==
X-Gm-Message-State: AOAM531Vr87ruloZDYmMX5UnVo2IvqOA+cPOMhqMVGdMi0iXBL7oRf5E
        DKd+pVfbvMtNdua3HxL9lw==
X-Google-Smtp-Source: ABdhPJwE593vXhJaye9kSIvUe7YgQJ63WWLPs3lUh0NNUGUV1LFegtWau5fpotYXrpDETQNm60O+YQ==
X-Received: by 2002:aca:5256:: with SMTP id g83mr2254356oib.71.1602681913507;
        Wed, 14 Oct 2020 06:25:13 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l138sm1307457oih.32.2020.10.14.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:25:12 -0700 (PDT)
Received: (nullmailer pid 1534606 invoked by uid 1000);
        Wed, 14 Oct 2020 13:25:11 -0000
Date:   Wed, 14 Oct 2020 08:25:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add L1 and L2 error detection for A53 and A57
Message-ID: <20201014132511.GA1517487@bogus>
References: <20201013125033.4749-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013125033.4749-1-s.hauer@pengutronix.de>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 13, 2020 at 02:50:30PM +0200, Sascha Hauer wrote:
> This driver is based on an earlier version from York Sun which can
> be found here: https://lkml.org/lkml/2018/3/14/1203.
> 
> At that time the conclusion was that this driver is not suitable for
> mainline as it used IMPLEMENTATION DEFINED CPU registers and also
> NXP specific SMC calls. All this was used for the error injection only,
> for error reporting it is not needed.

Have you looked at Amazon's version:
http://lore.kernel.org/r/20200510151310.17372-2-hhhawa@amazon.com

Which is an A57 EDAC driver. Looks like it never got upstream though, 
but it's not clear why.

You'll note that it doesn't have a virtual DT node either.

> This is another try to get this driver to mainline. All error injection
> code has been removed (though it has initially been used to test this
> driver on an i.MX8 SoC), what's left is unfortunately not testable, but
> also doesn't contain none of the doubtful code anymore.
> 
> Changes since v1:
> - Split dt-binding into separate patch
> - Sort local function variables in reverse-xmas tree order
> - drop unnecessary comparison and make variable bool
> 
> Sascha Hauer (2):
>   dt-bindings: edac: Add binding for L1/L2 error detection for Cortex
>     A53/57
>   drivers/edac: Add L1 and L2 error detection for A53 and A57
> 
> York Sun (1):
>   arm64: dts: ls104x: Add L1/L2 cache edac node
> 
>  .../bindings/edac/arm,cortex-a5x-edac.yaml    |  32 +++
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   5 +
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   5 +
>  drivers/edac/Kconfig                          |   6 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c             | 208 ++++++++++++++++++
>  6 files changed, 257 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
> 
> -- 
> 2.28.0
> 
