Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D732167A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhBVMXr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 07:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhBVMXY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 07:23:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CCC061574;
        Mon, 22 Feb 2021 04:22:44 -0800 (PST)
Received: from zn.tnic (p200300ec2f0402008ca1f4f712cbc8cf.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:200:8ca1:f4f7:12cb:c8cf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E28E1EC050D;
        Mon, 22 Feb 2021 13:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613996562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ljhihQwx9chR9lhZJgSKKh6JlCTcVb2u54fkWRxZeCM=;
        b=CWs7LgUffpmzmGWCsOvzdbbFv8trrKfB4y4xU7o6qBWEmiALd37UviYSwkmb6CFokpmlhl
        rGc8Ax5WKbKKNnOuDv8bOw4Sk6pyJHv8WgbmPYJGobPb+VZB1Vlu9+5OZqVbEq7lfmZuch
        9KIxuXhRlpQC7wfxhf9iaUdPUItR7Oc=
Date:   Mon, 22 Feb 2021 13:22:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222122241.GA10880@zn.tnic>
References: <20210222113124.35f2d552@alex-virtual-machine>
 <20210222115007.75b7de9b@alex-virtual-machine>
 <20210222092403.GA29063@zn.tnic>
 <20210222173109.7b7ac42a@alex-virtual-machine>
 <20210222100356.GB29063@zn.tnic>
 <20210222180819.3998fe33@alex-virtual-machine>
 <20210222102206.GC29063@zn.tnic>
 <20210222192146.76ffec84@alex-virtual-machine>
 <20210222201723.0fcec589@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222201723.0fcec589@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 08:17:23PM +0800, Aili Yao wrote:
> AR (Action Required) flag, bit 55 - Indicates (when set) that MCA
> error code specific recovery action must be...

Give me the *exact* MCE signature you're injecting please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
