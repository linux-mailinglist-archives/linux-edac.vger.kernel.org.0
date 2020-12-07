Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04D12D0EBF
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLGLON (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 06:14:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgLGLOM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Dec 2020 06:14:12 -0500
Received: from zn.tnic (p4fed31e1.dip0.t-ipconnect.de [79.237.49.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 212061EC0426;
        Mon,  7 Dec 2020 12:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607339611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d35eddzbqWSHez2jV9H7wuGFlrtTbqPqKgMe7Hcvtnc=;
        b=CAUu9mk3JaA3qk7MqKyddXKQhrJ0kjxe5kOQDGbt/vFyrLr0Xett2zUdSvjpixpr3/YOsP
        xHuoiokXsZJGU8uAaCut/tTDDdSoYMw2kFDpoefZffe4EPBRwW3WfizC48NMlcsl0podl/
        AZnNtY/FsUmyCuB5/HCJc5tB7G5e+cE=
Date:   Mon, 7 Dec 2020 12:11:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        leetroy@gmail.com, ryan_chen@aspeedtech.com
Subject: Re: [PATCH v4 1/3] dt-bindings: edac: aspeed-sdram-edac: Add
 ast2400/ast2600 support
Message-ID: <20201207111116.GB20489@zn.tnic>
References: <20201207090013.14145-1-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207090013.14145-1-troy_lee@aspeedtech.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Dec 07, 2020 at 05:00:11PM +0800, Troy Lee wrote:
> Adding Aspeed AST2400 and AST2600 binding for edac driver.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Acked-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/edac/aspeed-sdram-edac.txt       | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

All 3 applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
