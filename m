Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313C7402FE
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0SN7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Jun 2023 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjF0SNR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Jun 2023 14:13:17 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6E358E
        for <linux-edac@vger.kernel.org>; Tue, 27 Jun 2023 11:12:46 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 0380152C78; Tue, 27 Jun 2023 14:12:39 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 963ED527BB;
        Tue, 27 Jun 2023 14:12:18 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id ACE07220032; Tue, 27 Jun 2023 14:12:17 -0400 (EDT)
Date:   Tue, 27 Jun 2023 14:12:17 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [PATCH v3] mce: prevent concurrent polling of MCE events
Message-ID: <20230627181217.GA4090740@cathedrallabs.org>
References: <20230627173612.GZ4090740@cathedrallabs.org>
 <ZJslOOHwZzaDdK4Z@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJslOOHwZzaDdK4Z@agluck-desk3>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 27, 2023 at 11:06:48AM -0700, Tony Luck wrote:
> On Tue, Jun 27, 2023 at 01:36:12PM -0400, Aristeu Rozanski wrote:
> > +void intel_cmci_poll_unlock(bool locked)
> > +{
> > +	if (!locked)
> > +		return;
> > +
> > +	spin_unlock(&cmci_poll_lock);
> > +}
> 
> This doesn't need an argument any more. The unserialize_mc_bank_access()
> will only call it for the locked case.

And remove checking processor's vendor on unserialize_mc_bank_access()
as well.

-- 
Aristeu

