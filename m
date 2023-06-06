Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B1724523
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jun 2023 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjFFOBD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jun 2023 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjFFOAp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Jun 2023 10:00:45 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10910CC
        for <linux-edac@vger.kernel.org>; Tue,  6 Jun 2023 07:00:30 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 5B2A852C9B; Tue,  6 Jun 2023 10:00:29 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 06CD15280B;
        Tue,  6 Jun 2023 10:00:12 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id E83EB220095; Tue,  6 Jun 2023 10:00:11 -0400 (EDT)
Date:   Tue, 6 Jun 2023 10:00:11 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230606140011.GU4090740@cathedrallabs.org>
References: <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 06, 2023 at 10:25:41AM +0200, Borislav Petkov wrote:
> Lemme make sure you realize what you're arguing for: you want to not log
> MCE duplicates in a ring buffer which can get overwritten due to a bunch
> of reasons and as such is best effort only anyway.
> 
> Hell, it can get overwritten even by non-duplicate MCEs if they're just
> enough many to overflow the buffer's size.
> 
> So relying on dmesg for any serious error counting or whatnot is
> a exercise in futility.

I'm not sure when I made you believe I want to do error counting or
error parsing from the kernel log.

I started saying that we need to avoid, when possible, to waste kernel
log. Duplicates are a waste. You mentioned not even logging MCEs at all
and I said that I believe it's not right, as it might be useful to be
aware of MCEs being delivered before a crash.

--
Aristeu

