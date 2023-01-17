Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F566E76D
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjAQUIz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 15:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjAQUGt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 15:06:49 -0500
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A246D7E
        for <linux-edac@vger.kernel.org>; Tue, 17 Jan 2023 10:58:41 -0800 (PST)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 27509529DE; Tue, 17 Jan 2023 13:58:33 -0500 (EST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 03E6E52723;
        Tue, 17 Jan 2023 13:58:16 -0500 (EST)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id E28FA220056; Tue, 17 Jan 2023 13:58:15 -0500 (EST)
Date:   Tue, 17 Jan 2023 13:58:15 -0500
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [RFC PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <Y8bvxxuf7XIPwEFZ@cathedrallabs.org>
References: <Y8WtE7BNJ0gTrqIS@cathedrallabs.org>
 <SJ1PR11MB6083410C8464DEC926C0BDB9FCC69@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y8bsejfSuXZ/NaEu@cathedrallabs.org>
 <IA1PR11MB607672430721985FD208F00BFCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB607672430721985FD208F00BFCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 17, 2023 at 06:54:02PM +0000, Luck, Tony wrote:
> > Yes, but could change the patch to include mce_available() into the
> > protection of the lock. It should cleared once machine_check_poll() clears
> > the bank state, no?
> 
> Which machines are showing this problem? Most modern systems support
> CMCI. So I'm thinking that this case shows up because the sysadmin booted
> with "mce=no_cmc;". In that case I don't think mce_available() check would
> change anything.

That is correct, ignore what I said.

-- 
Aristeu

