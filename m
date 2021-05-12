Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870A37B6D4
	for <lists+linux-edac@lfdr.de>; Wed, 12 May 2021 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELH1Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 May 2021 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhELH1Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 May 2021 03:27:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4733C061574;
        Wed, 12 May 2021 00:26:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bb800f5aafbba26918162.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b800:f5aa:fbba:2691:8162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC3501EC047F;
        Wed, 12 May 2021 09:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620804366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XX7BymnssuDQenSuxH91S0T/FnRTEBAOK/1gKgHXGXk=;
        b=ldy07QIG2M6aYy1egamwXG50LfBbBb8j4mi+gP/S8UtULX9ALbQ+5ertfar+bp34CRdc+J
        Z3QVmX6AG1ZWVxE8xDZttj/drZQHsSsltKiVKcGmx4EWQE7r40/hb8WDaOPl7/s7GK+bkA
        sJGgFjxHn2sA6cs3fNeucwbZaKmzhJo=
Date:   Wed, 12 May 2021 09:26:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: [PATCH 2/3] x86/MCE/AMD: Helper function to check UMC v2
Message-ID: <YJuDClvyHl8mSHzp@zn.tnic>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <20210511152538.148084-2-nchatrad@amd.com>
 <YJrAOXEcyUvs/WvY@zn.tnic>
 <DM4PR12MB5263B138C38827A692411634EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263B138C38827A692411634EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mukul,

On Wed, May 12, 2021 at 01:40:54AM +0000, Joshi, Mukul wrote:
> [AMD Official Use Only - Internal Distribution Only]

first of all, please do not top-post.

> Thanks for the review comments.
> I will update the Subject line and send out an updated patch.

Ok.

> In the meantime, here is the link to where the changes in Patch 2 and 3 are being used:
> https://lists.freedesktop.org/archives/amd-gfx/2021-May/063423.html

Yes, in the future, please Cc x86@kernel.org too when you're
using/exporting facilities to be used by other subsystems.

I'll try to reply to that patch through lore.kernel.org now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
