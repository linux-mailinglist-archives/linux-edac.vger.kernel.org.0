Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FA7392EF
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfFGRU0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 13:20:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfFGRU0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 13:20:26 -0400
Received: from zn.tnic (p200300EC2F066300951FA2F4E0AD5C5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6300:951f:a2f4:e0ad:5c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11D6F1EC0985;
        Fri,  7 Jun 2019 19:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559928024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YuJItu/kY1OR+PCaPR3EBpygwkTuPT71+DHP7rNgI4o=;
        b=WHxWMfnTsuKeeaycfDr0wM5vkwX+Ut/TIaaiGjJCIhQhNNwGVkz47mEC2PrAglENkNLxrv
        hH4QoJx8mhUpC9Vz1vX1B2FTGfYiDn3KE25KDKnjzgNCEpIIij1bR09dZqv0veZTI05qqQ
        FfpHMiOus7pyMzn7/uFYXVYuMXyC6Tg=
Date:   Fri, 7 Jun 2019 19:20:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190607172023.GL20269@zn.tnic>
References: <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
 <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607163723.GG20269@zn.tnic>
 <SN6PR12MB263968DE0DD98EBE14450698F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607165902.GJ20269@zn.tnic>
 <SN6PR12MB263905712C2375078012E833F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263905712C2375078012E833F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 07, 2019 at 05:08:04PM +0000, Ghannam, Yazen wrote:
> Right, I took that branch, squashed the locking fix into patch 2,
> fixed up the remaining patches, and then redid the last patch.
>
> I plan to send the result as a v4 of this patchset with all the links,
> version history, etc. Is that what you mean?

Yap, exactly!

> Sorry, if I misunderstood.

No worries, we're on the same page now :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
