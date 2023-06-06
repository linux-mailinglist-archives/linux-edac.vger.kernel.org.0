Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F113723B78
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jun 2023 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFFIZu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jun 2023 04:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFFIZt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Jun 2023 04:25:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FBE8
        for <linux-edac@vger.kernel.org>; Tue,  6 Jun 2023 01:25:48 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 883191EC03B9;
        Tue,  6 Jun 2023 10:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686039946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1168hO3B0vE89ot/Lvev4C73vDnM2CLpYyir+o9Fm0U=;
        b=WTOBuY7tSkzVI0/88uwu3/IHI2jLFinwePyDP1R7rWwZZGax7yqcfSsAqBY+mj29KVAYjl
        kt8TdTrtajMZX+5lmqA7T7m16gNDZfsVtjJ65L9sLUH30nqRdQ5WieydxvO66ILPhXuTeN
        3XRRn7DBmNJZzQOtqHjnTYviTpz4Q/k=
Date:   Tue, 6 Jun 2023 10:25:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
References: <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605215839.GT4090740@cathedrallabs.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 05:58:39PM -0400, Aristeu Rozanski wrote:
> It makes support people's lives worse by reducing the amount of useful
> information in dmesg, when it can be avoided, in the case of duplicates.
> Getting rid of the messages completely would be harmful as well, not
> always customers run rasdaemon or provide the database with events, which
> sometimes can be useful as hints.

Lemme make sure you realize what you're arguing for: you want to not log
MCE duplicates in a ring buffer which can get overwritten due to a bunch
of reasons and as such is best effort only anyway.

Hell, it can get overwritten even by non-duplicate MCEs if they're just
enough many to overflow the buffer's size.

So relying on dmesg for any serious error counting or whatnot is
a exercise in futility.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
