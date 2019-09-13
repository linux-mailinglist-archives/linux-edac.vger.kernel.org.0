Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B378B24DC
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfIMSKe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 14:10:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:40824 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfIMSKe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 14:10:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 11:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197638414"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga002.jf.intel.com with ESMTP; 13 Sep 2019 11:10:32 -0700
Date:   Fri, 13 Sep 2019 11:10:31 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v3 1/4] x86/mce: Add Zhaoxin MCE support
Message-ID: <20190913181031.GA9940@agluck-desk2.amr.corp.intel.com>
References: <9d6769dca6394638a013ccad2c8f964c@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6769dca6394638a013ccad2c8f964c@zhaoxin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 11, 2019 at 12:01:42PM +0000, Tony W Wang-oc wrote:
> +	/* Checks after this one are Intel/Zhaoxin-specific: */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)


Is it time to have a big cleanup on how we handle similarities
and oddities in the MCE subsystem?  We've been adding ad-hoc
tests like this in random places ... and it all looks very
messy.  Lines that mention x86_vendor|x86|x86_model below
arch/x86/kernel/cpu/mce/ currently look like this:

arch/x86/kernel/cpu/mce/amd.c:		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
arch/x86/kernel/cpu/mce/amd.c:	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
arch/x86/kernel/cpu/mce/amd.c:	} else if (c->x86 == 0x17 &&
arch/x86/kernel/cpu/mce/amd.c:	if (c->x86 == 0x15 && bank == 4) {
arch/x86/kernel/cpu/mce/amd.c:	if (c->x86 == 0x17 &&
arch/x86/kernel/cpu/mce/core.c:	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
arch/x86/kernel/cpu/mce/core.c:	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
arch/x86/kernel/cpu/mce/core.c:	     c->x86 > 6) {
arch/x86/kernel/cpu/mce/core.c:	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
arch/x86/kernel/cpu/mce/core.c:	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
arch/x86/kernel/cpu/mce/core.c:	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 < 0x11 && cfg->bootlog < 0) {
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 0x15 && c->x86_model <= 0xf)
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
arch/x86/kernel/cpu/mce/core.c:	if (c->x86 != 5)
arch/x86/kernel/cpu/mce/core.c:		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
arch/x86/kernel/cpu/mce/core.c:	if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 6 && c->x86_model == 45)
arch/x86/kernel/cpu/mce/core.c:		if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
arch/x86/kernel/cpu/mce/core.c:	if (c->x86_vendor == X86_VENDOR_AMD) {
arch/x86/kernel/cpu/mce/core.c:	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
arch/x86/kernel/cpu/mce/core.c:	if (c->x86_vendor == X86_VENDOR_INTEL) {
arch/x86/kernel/cpu/mce/core.c:	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
arch/x86/kernel/cpu/mce/core.c:	m->cpuvendor = boot_cpu_data.x86_vendor;
arch/x86/kernel/cpu/mce/core.c:	switch (c->x86_vendor) {
arch/x86/kernel/cpu/mce/inject.c:	    boot_cpu_data.x86 < 0x17) {
arch/x86/kernel/cpu/mce/inject.c:	m->cpuvendor = boot_cpu_data.x86_vendor;
arch/x86/kernel/cpu/mce/intel.c:	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
arch/x86/kernel/cpu/mce/intel.c:	switch (c->x86_model) {
arch/x86/kernel/cpu/mce/severity.c:	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
arch/x86/kernel/cpu/mce/severity.c:	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
arch/x86/kernel/cpu/mce/therm_throt.c:		if (c->x86 == 6 && (c->x86_model == 9 || c->x86_model == 13)) {

Maybe we can X86_VENDOR_ZHAOXIN to this jumble with the excuse that
it is already so ugly that this patch series only makes things 5% worse?

Or should we make a big table of CPU vendors/families/models and use
x86_match_cpu() to pick out what are running on and set some bits/flags
(like X86_FEATURE/X86_BUG) which we can use in the code to do the
right thing in each place?

E.g. default for Intel and Zhaoxin vendors would be to set MCE_INTEL_LIKE.

Thoughts?

-Tony
