Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D32937E1
	for <lists+linux-edac@lfdr.de>; Tue, 20 Oct 2020 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391269AbgJTJTx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 20 Oct 2020 05:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391233AbgJTJTx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 20 Oct 2020 05:19:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EFCC061755
        for <linux-edac@vger.kernel.org>; Tue, 20 Oct 2020 02:19:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f106600748f54fac26d0739.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:6600:748f:54fa:c26d:739])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D88951EC0258;
        Tue, 20 Oct 2020 11:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603185592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uR59hxLIrj7+jaCGNVOPFlPKbpxrwplNI5vYRZAuvjc=;
        b=JiSIdY3XQRv0H6xIpxm8nEim4C74kRWDV7Yo/7xuPxuxIkCBHywMSiqxbN3AaDzGfLfXJ2
        AA6E4XY4O2zu1v/XLWi+d4sWiF3qUD9rn6sf2XC/qo3iUbbbV4o811tU6seKaIFNvnUS0m
        z4ZfZXR6AE5qKMlhzS/YT/zQ+WlADdg=
Date:   Tue, 20 Oct 2020 11:19:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Raymond Bennett <raymond.bennett@gmail.com>,
        linux-edac@vger.kernel.org
Subject: Re: Constant output in syslog of EDAC message
Message-ID: <20201020091940.GA11583@zn.tnic>
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
 <20201019205658.GI24325@zn.tnic>
 <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 19, 2020 at 05:25:43PM -0400, Jason Baron wrote:
> Yes, I likely was just following what was in other edac drivers at
> the time - for example, i3200_check() has a similar debug. I guess
> it could have a higher level. But if we remove this one, we may
> want to audit some of the other edac drivers as well.

Sounds good. So one patch removing them all would make sense. If
you feel like doing it, be my guest. Otherwise, it'll land on my
ever-growing todo. :-\

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
