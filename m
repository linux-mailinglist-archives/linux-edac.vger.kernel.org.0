Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A916CB16C
	for <lists+linux-edac@lfdr.de>; Tue, 28 Mar 2023 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjC0WHO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Mar 2023 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjC0WHN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Mar 2023 18:07:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4919AB;
        Mon, 27 Mar 2023 15:07:11 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A78CF1EC0529;
        Tue, 28 Mar 2023 00:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679954829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uTvrkvRBOkm6k6Rg1Q92jvvbdCcLR4Zco9jZIpniGC0=;
        b=FNeUThu0H61wHvzS9RH6RzIAXY+hZZd1+8Ne/HLEXwKfr0azNvXeAloZ6Hu+cKd1LBf5+u
        UMcnJF14EOb2HbjSsYwoPb3sNGbwvyoKnVJ+Pw+ODaX7Xkg6nf3recMrx2mD+FZ55n9TwI
        Yi/8szHGNEdIJoWfuk7O1aEpAifW/0M=
Date:   Tue, 28 Mar 2023 00:07:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     kyle-meyer <kyle.meyer@hpe.com>, dimitri.sivanich@hpe.com,
        steve.wahl@hpe.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, qiuxu.zhuo@intel.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Message-ID: <20230327220705.GFZCITiXbkfun7oh21@fat_crate.local>
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
 <20230324004919.GHZBzzj1FzwEZclTCL@fat_crate.local>
 <ZB4NFzrf09D1J47m@yaz-khff.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4NFzrf09D1J47m@yaz-khff.amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 24, 2023 at 04:50:31PM -0400, Yazen Ghannam wrote:
> How about "/sys/ras" to collect global RAS interfaces?

Looking a bit at

Documentation/admin-guide/sysfs-rules.rst

it does sound like /sys/<subsystem> could be a good place. Might wanna
run it by Greg, though, first.

> Maybe it can link to other directories like "/sys/devices/*" for
> hardware things like MCA,

Those are at

/sys/devices/system/machinecheck/

> and "/sys/kernel/*" for kernel things like CEC.

Or /sys/drivers

Remember there's also

/sys/devices/system/edac/

so a lot of RAS junk spread all over the place.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
