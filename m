Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE3390A5B
	for <lists+linux-edac@lfdr.de>; Tue, 25 May 2021 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhEYUOX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 May 2021 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhEYUOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 May 2021 16:14:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C5C061574;
        Tue, 25 May 2021 13:12:52 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c1b002e9a6969de3a19f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1b00:2e9a:6969:de3a:19f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95EB71EC0249;
        Tue, 25 May 2021 22:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621973570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0oczzyVicJSWXsQMSbTAEPrWE1pjbktvObtdG3YBcsA=;
        b=IbCyWqriver8SMcwlr5ltJeBrU1OL7CN56C99mmkZp6ltV97+p/oZeCw8/05Et4zXvg3fb
        +2HoFrqsIpn8NejWNAR3CGTkcklmYzTXKwcu6M1MuEsnpeWzMIJsMmrxfAkvxK0j9kA0bT
        Cr2cA/Cb1A+KbWlIkMb0r+arj+HaPCw=
Date:   Tue, 25 May 2021 22:12:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "M K, Muralidhara" <Muralidhara.MK@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Message-ID: <YK1aPCwdO2T/ux9r@zn.tnic>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <YJq+ca+kJ4cRl5B8@zn.tnic>
 <DM6PR12MB4388D2F749166A72974718C6E8269@DM6PR12MB4388.namprd12.prod.outlook.com>
 <YK07xEG4567yv8vl@zn.tnic>
 <20210525200327.GA8891@aus-x-yghannam.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525200327.GA8891@aus-x-yghannam.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 25, 2021 at 04:03:27PM -0400, Yazen Ghannam wrote:
> Yep, that's right. The UMCs are the only case of this so far and in the
> foreseeable future. Though we may be moving towards more cases like
> this.

Ok, then you guys really need to make sure those strings are unique
because they're in sysfs:

/sys/devices/system/machinecheck/machinecheck...

AFAIR, so we can't have duplicates there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
