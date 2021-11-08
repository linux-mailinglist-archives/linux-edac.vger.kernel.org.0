Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9154447E0A
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 11:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhKHKea (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 05:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhKHKe3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 05:34:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D3C061570;
        Mon,  8 Nov 2021 02:31:45 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 554BF1EC0104;
        Mon,  8 Nov 2021 11:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636367504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fa1Piwlh5b1P8ydsjVHKQ6Epl5PmVZb3iEFXBDswZlM=;
        b=PV/p+KxNTeGXRtYzcA8EjOR6ec3jA3ghHT9EJF2epwS6PLNFxaR/DRpo/jJGCT5hWjW4MB
        s4VZZAPgcmyXjU/fk74wr8V74eRl+C42/Z8lYYd2bGaVBU3iWfurpG/0oZ+zCOBwHV8QBW
        a4IwKrs+pfAqsD2Kn6BFFHeu3kBCxeI=
Date:   Mon, 8 Nov 2021 11:31:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhaolong Zhang <zhangzl2013@126.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/mce: drop cpu_missing since we have more capable
 mce_missing_cpus
Message-ID: <YYj8ir/UYnG/zVK4@zn.tnic>
References: <572d793c.f2e.17cede4cbf0.Coremail.zhangzl2013@126.com>
 <20211108082832.142436-1-zhangzl2013@126.com>
 <YYjuiHN1wKt82fjs@zn.tnic>
 <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d526023.3cde.17cff097bab.Coremail.zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 08, 2021 at 06:13:04PM +0800, Zhaolong Zhang wrote:
> I was concerning that if I simply remove the cpu_missing code, we will lose the log in the
> situation where mca_cfg.tolerant > 1 and no_way_out is set afterwards.
> 
> Do you think we can safely ignore that situation?

Well, how likely is to have such a situation in practice?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
