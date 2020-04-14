Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40BA1A805B
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405137AbgDNOtW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 10:49:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:35551 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404893AbgDNOtV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 10:49:21 -0400
IronPort-SDR: pkS1TwrRBC51v1wJiV3bw7VddVSGzmdtIQPHGaRnkDRxeTHa/5cTetYRnJNyVxI0N5xEVt40OB
 2T6aL7sz8fww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 07:49:17 -0700
IronPort-SDR: GjIpOW2k/RoVuVkcRzkpJCSVz5Lypre4fXwzI8Gc2K2Rc8HR7bI//zLWy4VqwzS6dJnAlznyXw
 +4jhBO1FUTxQ==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="399973646"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.11.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 07:49:16 -0700
Message-ID: <64f368b6bfde0611d3a1bc24884242bc4fb4cecd.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] x86/mce/therm_throt: remove unused
 platform_thermal_notify function pointer
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bberg@redhat.com, bp@suse.de
Date:   Tue, 14 Apr 2020 07:49:15 -0700
In-Reply-To: <CAHmME9rOzmF4K965U69tFZi2SS3rW9SHed2bJ=_PD+xu8LqMYw@mail.gmail.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
         <bad9e0bd5504df83092c7add2d84331e164b60cc.camel@linux.intel.com>
         <CAHmME9rOzmF4K965U69tFZi2SS3rW9SHed2bJ=_PD+xu8LqMYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2020-04-13 at 22:21 -0600, Jason A. Donenfeld wrote:
> On Mon, Apr 13, 2020 at 9:56 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Tue, 2020-04-07 at 00:33 -0600, Jason A. Donenfeld wrote:
> > > A long time ago platform_thermal_notify was added as some generic
> > > mechanism for platform drivers to hook thermal events. It seems
> > > as
> > > though this has been entirely superseded, and nothing uses it.
> > > Remove
> > > the plumbing for this, since this code runs in an interrupt hot
> > > path.
> > Good idea.
> 
> Will you take this into your tree?
I am not the maintainer of this tree. So I don't decide this. I can
just give my opinion.

>  If not, how do your thermal patches
> usually go in? A reviewed-by might be useful in that case.
For this patch:

Reviewed-by: Pandruvada, Srinivas <srinivas.pandruvada@linux.intel.com>

> 
> Jason

