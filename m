Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9C7231D5
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjFEVB2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjFEVB1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 17:01:27 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59CF2
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 14:01:26 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 60B2B528DB; Mon,  5 Jun 2023 17:01:25 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 8F5BF5280B;
        Mon,  5 Jun 2023 17:01:08 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 8046B22009F; Mon,  5 Jun 2023 17:01:08 -0400 (EDT)
Date:   Mon, 5 Jun 2023 17:01:08 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230605210108.GS4090740@cathedrallabs.org>
References: <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 10:56:58PM +0200, Borislav Petkov wrote:
> On Mon, Jun 05, 2023 at 04:33:15PM -0400, Aristeu Rozanski wrote:
> > Problem with throwing this userspace is that it won't get rid of the
> > duplication on the kernel log.
> 
> The kernel log never was and is a source to be scraped for hw errors.
> The right thing is called tracepoints and rasdaemon uses them already.

Yes, but I'm talking about flooding the log with duplicates.

-- 
Aristeu

