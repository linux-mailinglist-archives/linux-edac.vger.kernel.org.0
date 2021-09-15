Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A935340C47D
	for <lists+linux-edac@lfdr.de>; Wed, 15 Sep 2021 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhIOLp6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Sep 2021 07:45:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34354 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhIOLp5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Sep 2021 07:45:57 -0400
Received: from zn.tnic (p200300ec2f0d07000c3d48728178681f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:700:c3d:4872:8178:681f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3BD81EC0493;
        Wed, 15 Sep 2021 13:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631706273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pZe91PWAGAHyYwpLFuHme7Msmp8+16JEH9p61pfjk4M=;
        b=IPLgfFuloBs2qlHtMxthKskL/8ufL9mDC2okxm36F4zuezYEeK2cij7Zg22aQE0N5Iudem
        yeHacpFw5o1fFjDslqU4FRlI1Sy1AbiQpQgDiff4S0Jg2AA45BfHDGpshQZ3hBm6HwdKLI
        SMaMWfFYQ9aKmBvz4p5UWWr9/dFJR9g=
Date:   Wed, 15 Sep 2021 13:44:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     michal.simek@xilinx.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
Message-ID: <YUHcmlo2c4t9MSKK@zn.tnic>
References: <20210831200316.3208310-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831200316.3208310-1-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 31, 2021 at 03:03:15PM -0500, Dinh Nguyen wrote:
> This patch adds support for version 3.80a of the Synopsys DDR controller

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> with EDAC. This version of the controller has the following differences:
> 
> - UE/CE are auto cleared
> - Interrupts are supported by default
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/edac/synopsys_edac.c | 53 ++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 9 deletions(-)

In any case, am I supposed to take this or is this expecting some Ack
from Michal first?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
