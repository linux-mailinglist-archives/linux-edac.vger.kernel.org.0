Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6773BC42
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 18:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjFWQB5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWQB4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 12:01:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDAE210A;
        Fri, 23 Jun 2023 09:01:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF4341EC041E;
        Fri, 23 Jun 2023 18:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687536113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L+QS7bY84GEwN5T2VJx13l5ClU5BnzbSuIpiu4GKWYk=;
        b=JulMNEWAf4eIXKGiQ2q8LyZ0QskeBZUc75j9M/b63SYOnG1f+/kJ+0z157m9X4lS7ebpi4
        Hf/uu5LYHgYCrz7qNix5f7FAGvlJrO7AjwW6LxJZSLjEOYgaagm5ZpVEJO6kavZW8B0OJ5
        0fLOSX4yU0QpP5LvygNv+Vh/PVepqbQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EN1lP9rypIGF; Fri, 23 Jun 2023 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687536110; bh=L+QS7bY84GEwN5T2VJx13l5ClU5BnzbSuIpiu4GKWYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CU8KvKQNOudf+eTF3Q73Z7N9+c52HbH+pDjQ9pX0RKrp1P1vGafoW0pfjJ6dL6Dql
         h0kP0NMn00QhwuDni8YZm6kfrJDQHOQKCbU8YpBFV6t9f/MNXjxePhh6rY9P4VpryR
         ptEi5vH78DPmlFDIJS02fckSFgORx0VIrQM17waqm11/6r70L7ZFEJ9GsExcK/BWOZ
         0nHcnHlBap+sJ/EhggGsw+xFdZHard2J5MwRTntqngTzAF6ceZ+xIfNHrf1IBrx/9L
         gdsLUzmtYHVqUeYUV/LXpoCvIZKYeQ+IZBgb1cqQUljFRwIVBsELlwP+/7LWtWiNh/
         eEqgo8YxbRoObFS76+nr/oCn1zNzBpTRvz9je/BcXEoQNsbEJpYs+7npToAi0KTkES
         8Yre4TDrp51ydsRI9he3reLpaw3gBmh+sgJnXKmFEMfNR51HuaWpMDVTs9pF0v9EBb
         zF8gYfGlEV5qCpmkUpo9MrV0AQNhcXb7HYs6lCWxdwDQ00kfjyP923OBiRR+mJjaQc
         /cRvIgzf3+f2ct8FJN9m4XM7CAFWNGz9s18tWrlLPgEPBz3rB067+YdDxVzrf+2wpB
         SmoaZnAWm88dcPwb+tcVW6ilt9hxThMrVOSigQLOmFWcx/qYPPrsQDWWw3mYF4fWuL
         OtOATsWwSjoqkDfc0jyXBcWc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E37AA40E01D0;
        Fri, 23 Jun 2023 16:01:43 +0000 (UTC)
Date:   Fri, 23 Jun 2023 18:01:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Message-ID: <20230623160138.GBZJXB4hlFM/ahvROH@fat_crate.local>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
 <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 23, 2023 at 03:44:06PM +0000, Luck, Tony wrote:
> There is (or was) support for mixed stepping in the microcode update
> code. Not sure if Boris and Ashok came to any agreement on keeping it.

Yap, needs to stay on AMD as the loader has always supported it.

Btw, you might wanna update your bookmarks - bp@suse.de doesn't work
anymore. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
