Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4CA3E5C49
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhHJNy2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhHJNy1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Aug 2021 09:54:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87357C0613D3;
        Tue, 10 Aug 2021 06:54:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d650032a7c3e3b83a4c54.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6500:32a7:c3e3:b83a:4c54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 804C71EC0345;
        Tue, 10 Aug 2021 15:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628603638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wy0O3e24ZiuBDTN+sdm5ZVuQfM7Q7G9zPYzrOaizwCs=;
        b=ZMNituR4rApaF2UHuKbkO1Smmnc5TClj8CptOX/+I8T1/BBlFukUMJP8LRKLOYiEhlrNYW
        4JMYEaqREmSHsXVv51V2+fUyrAiXiFhb9RdXnKVdfusNRU2RVug5CSRqkBgmFL8PjJBihd
        UWY7tav0rZ3dboeVncrZyRgTr4zl1Z4=
Date:   Tue, 10 Aug 2021 15:54:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs
Message-ID: <YRKFHuj/2K4FHZS+@zn.tnic>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-2-nchatrad@amd.com>
 <20210719192830.GA19451@aus-x-yghannam.amd.com>
 <BL1PR12MB5286FFF1B2B421A2E37DDF44E8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5286FFF1B2B421A2E37DDF44E8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 10, 2021 at 12:45:17PM +0000, Chatradhi, Naveen Krishna wrote:
> But I think this patch can be part of the next patch
> where this value is first used. [naveenk:] Squashed
> this change into the 2nd patch and submitted v2
> https://patchwork.kernel.org/project/linux-edac/patch/20210806074350.1
> 14614-2-nchatrad@amd.com/

Btw, I'd suggest you find someone at AMD to teach you to use a proper
mail client for replying to lkml messages which does proper quoting,
etc. Outlook and windoze simply isn't cut out for this type of
communication but rather for managerial blabla.

Alternatively, you can read this here:

https://www.kernel.org/doc/html/latest/process/email-clients.html

and try to set up something yourself.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
