Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE116F368
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 00:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgBYX3X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 18:29:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:35713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbgBYX3W (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 18:29:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 15:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="231618923"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2020 15:29:00 -0800
Date:   Tue, 25 Feb 2020 15:29:00 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Message-ID: <20200225232900.GO9245@linux.intel.com>
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200225221234.GL9245@linux.intel.com>
 <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 25, 2020 at 02:52:32PM -0800, Jacob Keller wrote:
> On 2/25/2020 2:12 PM, Sean Christopherson wrote:
> > On Tue, Feb 25, 2020 at 01:49:13PM -0800, Jacob Keller wrote:
> >> Hi Sean,
> >>
> >> I suspect something is wrong and the features are enabled even though
> >> the BIOS has it disabled, leading to later failure because of this.
> > 
> > Hrm.  On the failing kernel, what are the values of MSR 0x3a for all CPUs,
> > i.e. what's the output of 'sudo rdmsr -a 0x3a'?
> > 
> 
> On the old (fedora 30) kernel, every cpu reports as '1'.
> 
> I can't easily test the failing kernel because it crashes during boot.

No need, your BIOS is likely locking the MSR, I doubt the value is any
different when running the new kernel.

Does reverting commit a4d0b2fdbcf7 ("KVM: VMX: Use VMX feature flag to
query BIOS enabling") resolve the issue?

Is the failing kernel an (umodified) upstream kernel?  A stable kernel?
Or something else?  Assuming it's an unmodified upstream kernel, can you
send your .config?  I've tried all the obvious Kconfig combinations but
haven't been able to reproduce the problem.  Staring at the code hasn't
yielded any revelations either.
