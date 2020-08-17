Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6800B24602D
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 10:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHQIa1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHQIaZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Aug 2020 04:30:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41769C061388;
        Mon, 17 Aug 2020 01:30:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be0058d52f19a716912e.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:58d5:2f19:a716:912e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD2FF1EC027B;
        Mon, 17 Aug 2020 10:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597653019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JLKtPfrL6Y+vdcTcPW5s3ea4Nrvn9k/+cPJOKCh5Zp0=;
        b=iPQ43NwIS/vpzE24zP6c0HOjsmPrxYMoHYBgFlFWS3Qa+/F8zg2mfa75F9EoVoDorsqHm9
        FbrMlORhh0sKVPLAHNeXZ301JFA8RRxe81igShIavgdAHGA8NSq1bv+EjLuRchRfm1eD5r
        1jMr8mwMHLu0pXeXJ90oD4AzNazSdSQ=
Date:   Mon, 17 Aug 2020 10:31:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Talel Shenhar <talel@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        eitan@amazon.com
Subject: Re: [PATCH v10 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Message-ID: <20200817083113.GA549@zn.tnic>
References: <20200816185551.19108-1-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200816185551.19108-1-talel@amazon.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 16, 2020 at 09:55:49PM +0300, Talel Shenhar wrote:
> Talel Shenhar (2):
>   dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory
>     Controller EDAC
>   EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller
>     EDAC
> 
>  .../bindings/edac/amazon,al-mc-edac.yaml      |  67 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/edac/Kconfig                          |   7 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/al_mc_edac.c                     | 354 ++++++++++++++++++
>  5 files changed, 436 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
>  create mode 100644 drivers/edac/al_mc_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
