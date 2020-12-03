Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C472CD4B9
	for <lists+linux-edac@lfdr.de>; Thu,  3 Dec 2020 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgLCLkG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Dec 2020 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbgLCLkG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Dec 2020 06:40:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D24C061A4D;
        Thu,  3 Dec 2020 03:39:26 -0800 (PST)
Received: from zn.tnic (p200300ec2f0dc5005cbee08096bf44b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:5cbe:e080:96bf:44b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C59381EC01A2;
        Thu,  3 Dec 2020 12:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606995564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XdizxemelBKbAsfei8gCNazQZJgzDRsHCkqt5ztY6qI=;
        b=lZsBzGOvlsbpcx9tXgxvCEh1XJb1pnnHMUVRGTLeTSjlLWaZeWq8F7cS+iliEUOCEpGCgI
        gE8/wvyamZjbAUq8WI3cR6Q72qFMN4EhZsPX5TKoay00j1utTgZkmMkg5pjbCSmJfDPgf2
        DAALOfaictINiASjQha8FuvIfI+uC9Y=
Date:   Thu, 3 Dec 2020 12:39:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>, mchehab@kernel.org,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] EDAC, mv64x60: Fix error return code in
 mv64x60_pci_err_probe()
Message-ID: <20201203113920.GG3059@zn.tnic>
References: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
 <20201202112515.GC2951@zn.tnic>
 <87pn3ruo2q.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pn3ruo2q.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 03, 2020 at 10:27:25PM +1100, Michael Ellerman wrote:
> It's dead code, so drop it.
> 
> I can send a patch if no one else wants to.

Yes please.

I love patches removing code! :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
