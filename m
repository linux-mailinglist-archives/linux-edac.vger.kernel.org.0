Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A007722F52
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjFETJ1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjFETJP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 15:09:15 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BA1A7
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 12:09:05 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id D269752C9B; Mon,  5 Jun 2023 15:09:03 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id DA86B5280B;
        Mon,  5 Jun 2023 15:08:46 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id CD0D222009F; Mon,  5 Jun 2023 15:08:46 -0400 (EDT)
Date:   Mon, 5 Jun 2023 15:08:46 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230605190846.GO4090740@cathedrallabs.org>
References: <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 07:41:04PM +0200, Borislav Petkov wrote:
> I have no clue what "they can use thresholding to signal UCNA without
> signaling any corrected events and it won't work with CMCI enabled."

That's pretty much exactly what was passed to me. I'll ask who the
Intel contact was and inform Tony so they can talk internally.

--
Aristeu

