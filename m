Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F7723296
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 23:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFEV66 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFEV66 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 17:58:58 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F74EA
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 14:58:57 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 7003052C3E; Mon,  5 Jun 2023 17:58:56 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 4EF235280B;
        Mon,  5 Jun 2023 17:58:39 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 3DF4F22009F; Mon,  5 Jun 2023 17:58:39 -0400 (EDT)
Date:   Mon, 5 Jun 2023 17:58:39 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230605215839.GT4090740@cathedrallabs.org>
References: <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 11:06:10PM +0200, Borislav Petkov wrote:
> On Mon, Jun 05, 2023 at 05:01:08PM -0400, Aristeu Rozanski wrote:
> > Yes, but I'm talking about flooding the log with duplicates.
> 
> And?
> 
> We don't *have* to log them if someone's too confused by staring at
> something someone should not be staring at in the first place.

It makes support people's lives worse by reducing the amount of useful
information in dmesg, when it can be avoided, in the case of duplicates.
Getting rid of the messages completely would be harmful as well, not
always customers run rasdaemon or provide the database with events, which
sometimes can be useful as hints.

> But let's see how valid that "use case" actually is first...

Of course. Tony is already aware who inside Intel talked to them and
they'll talk.

--
Aristeu

