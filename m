Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50770DEF3
	for <lists+linux-edac@lfdr.de>; Tue, 23 May 2023 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjEWOPv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 May 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjEWOPp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 May 2023 10:15:45 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C2E9
        for <linux-edac@vger.kernel.org>; Tue, 23 May 2023 07:15:42 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 7248252DCF; Tue, 23 May 2023 10:15:40 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 75B99527BB;
        Tue, 23 May 2023 10:15:23 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 641BE220035; Tue, 23 May 2023 10:15:23 -0400 (EDT)
Date:   Tue, 23 May 2023 10:15:23 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230523141523.GL4090740@cathedrallabs.org>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 08:07:10PM +0000, Luck, Tony wrote:
> I disabled CMCI for debugging reasons. Aristeu needs to comment on
> his use case.

Got an answer from them. They disable it in two lines of products
(one uses IceLake, the other uses Sapphire Rapids) and in these lines
they can use thresholding to signal UCNA without signaling any corrected
events and it won't work with CMCI enabled. They did make Intel aware of
it (maybe you heard details about it? If not I can get them in contact with
you) but it's not certain if this can be fixed or not.

-- 
Aristeu

