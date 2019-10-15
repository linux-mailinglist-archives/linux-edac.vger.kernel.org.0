Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925D3D77DE
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJOOBs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 10:01:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:10250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732170AbfJOOBs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Oct 2019 10:01:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 07:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="220428257"
Received: from spandruv-mobl3.jf.intel.com ([10.254.34.58])
  by fmsmga004.fm.intel.com with ESMTP; 15 Oct 2019 07:01:47 -0700
Message-ID: <1cbbc768361bdf6e9058d9173fa9ef9ba965feba.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Tue, 15 Oct 2019 07:01:46 -0700
In-Reply-To: <20191015084614.GB596@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
         <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
         <20191014213618.GK4715@zn.tnic>
         <3055e340ebaba9f8fb587a11ce3f25cf33919ab3.camel@linux.intel.com>
         <20191015084614.GB596@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-10-15 at 10:46 +0200, Borislav Petkov wrote:
> On Mon, Oct 14, 2019 at 03:41:38PM -0700, Srinivas Pandruvada wrote:
> > So some users who had issues in their systems can try with this
> > patch.
> > We can get rid of this, till it becomes real issue.
> 
> We don't add command line parameters which we maybe can get rid of
> later.
I am saying the same.
We will not have command line parameter, till this is a problem.

Thanks,
Srinivas

> 
> > The temperature is function of load, time and heat dissipation
> > capacity
> > of the system. I have to think more about this to come up with some
> > heuristics where we still warning users about real thermal issues.
> > Since value is not persistent, then next boot again will start from
> > the
> > default.
> 
> Yes, and the fact that each machine's temperature is influenced by
> the
> specific *individual* environment and load the machine runs, shows
> that
> you need to adjust this timeout automatically and dynamically.
> 
> With the command line parameter you're basically putting the onus on
> the
> user to do that which is just silly. And then she'd need to do it
> during
> runtime too, if the ambient temperature or machine load, etc,
> changes.
> 
> The whole thing is crying "dynamic".
> 
> For a simple example, see mce_timer_fn() where we switch to polling
> during CMCI storms.
> 

