Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F227CC54A
	for <lists+linux-edac@lfdr.de>; Fri,  4 Oct 2019 23:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJDV41 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 17:56:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:5964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbfJDV41 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Oct 2019 17:56:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 14:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="191710644"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 14:56:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 00/16] x86/cpu: Clean up handling of VMX features
Date:   Fri,  4 Oct 2019 14:55:59 -0700
Message-Id: <20191004215615.5479-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Clean up a handful of interrelated warts in the kernel's handling of VMX:

  - Enable VMX in IA32_FEATURE_CONTROL during boot instead of on-demand
    during KVM load to avoid future contention over writing the MSR.

  - Rework VMX feature reporting so that it is accurate and up-to-date,
    now and in the future.

  - Consolidate code across CPUs that support VMX.

The patches are based on tip/x86/cpu, commit
 
  87d6021b8143 ("x86/math-emu: Limit MATH_EMULATION to 486SX compatibles")

Please let me know if you'd prefer not to receive the full patch set on
future versions of the series.  I cc'd everyone on all patches to provide
the full picture, e.g. the motivation behind things like the perf patch.


This series stems from two separate but related issues.  The first issue,
pointed out by Boris in the SGX enabling series[1], is that the kernel
currently doesn't ensure the IA32_FEATURE_CONTROL MSR is configured during
boot.  The second issue is that the kernel's reporting of VMX features is
stale, potentially inaccurate, and difficult to maintain.

== IA32_FEATURE_CONTROL ==
Lack of IA32_FEATURE_CONTROL configuration during boot isn't a functional
issue in the current kernel as the majority of platforms set and lock
IA32_FEATURE_CONTROL in firmware.  And when the MSR is left unlocked, KVM
is the only subsystem that writes IA32_FEATURE_CONTROL.  That will change
if/when SGX support is enabled, as SGX will also want to fully enable
itself when IA32_FEATURE_CONTROL is unlocked.

== VMX Feature Reporting ==
VMX features are not enumerated via CPUID, but instead are enumerated
through VMX MSRs.  As a result, new VMX features are not automatically
reported via /proc/cpuinfo.

An attempt was made long ago to report interesting and/or meaningful VMX
features by synthesizing select features into a Linux-defined cpufeatures
word.  Synthetic feature flags worked for the initial purpose, but the
existence of the synthetic flags was forgotten almost immediately, e.g.
only one new flag (EPT A/D) has been added in the the decade since the
synthetic VMX features were introduced, while VMX and KVM have gained
support for many new features.

Placing the synthetic flags in x86_capability also allows them to be
queried via cpu_has() and company, which is misleading as the flags exist
purely for reporting via /proc/cpuinfo.  KVM, the only in-kernel user of
VMX, ignores the flags.

Last but not least, VMX features are reported in /proc/cpuinfo even
when VMX is unusable due to lack of enabling in IA32_FEATURE_CONTROL.

== Caveats ==
All of the testing of non-standard flows was done in a VM, as I don't
have a system that leaves IA32_FEATURE_CONTROL unlocked, or locks it with
VMX disabled.

The Centaur and Zhaoxin changes are somewhat speculative, as I haven't
confirmed they actually support IA32_FEATURE_CONTROL, or that they want to
gain "official" KVM support.  I assume they unofficially support KVM given
that both CPUs went through the effort of enumerating VMX features.  That
in turn would require them to support IA32_FEATURE_CONTROL since KVM will
fault and refuse to load if the MSR doesn't exist.

[1] https://lkml.kernel.org/r/20190925085156.GA3891@zn.tnic


Sean Christopherson (16):
  x86/intel: Initialize IA32_FEATURE_CONTROL MSR at boot
  x86/mce: WARN once if IA32_FEATURE_CONTROL MSR is left unlocked
  x86/centaur: Use common IA32_FEATURE_CONTROL MSR initialization
  x86/zhaoxin: Use common IA32_FEATURE_CONTROL MSR initialization
  KVM: VMX: Drop initialization of IA32_FEATURE_CONTROL MSR
  x86/cpu: Clear VMX feature flag if VMX is not fully enabled
  KVM: VMX: Use VMX feature flag to query BIOS enabling
  KVM: VMX: Check for full VMX support when verifying CPU compatibility
  x86/vmx: Introduce VMX_FEATURES_*
  x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs
  x86/cpu: Print VMX features as separate line item in /proc/cpuinfo
  x86/cpufeatures: Drop synthetic VMX feature flags
  KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits
  x86/cpufeatures: Clean up synthetic virtualization flags
  perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
  KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin
    CPUs

 MAINTAINERS                           |   2 +-
 arch/x86/Kconfig.cpu                  |   8 ++
 arch/x86/boot/mkcpustr.c              |   1 +
 arch/x86/include/asm/cpufeatures.h    |  15 +---
 arch/x86/include/asm/perf_event.h     |  22 +++--
 arch/x86/include/asm/processor.h      |   4 +
 arch/x86/include/asm/vmx.h            | 105 +++++++++++-----------
 arch/x86/include/asm/vmxfeatures.h    | 121 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/Makefile          |   6 +-
 arch/x86/kernel/cpu/centaur.c         |  35 +-------
 arch/x86/kernel/cpu/common.c          |   3 +
 arch/x86/kernel/cpu/cpu.h             |   4 +
 arch/x86/kernel/cpu/feature_control.c | 106 ++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c           |  49 +----------
 arch/x86/kernel/cpu/mce/intel.c       |   7 +-
 arch/x86/kernel/cpu/mkcapflags.sh     |  15 +++-
 arch/x86/kernel/cpu/proc.c            |  15 ++++
 arch/x86/kernel/cpu/zhaoxin.c         |  35 +-------
 arch/x86/kvm/Kconfig                  |   9 +-
 arch/x86/kvm/vmx/vmx.c                |  41 ++-------
 20 files changed, 368 insertions(+), 235 deletions(-)
 create mode 100644 arch/x86/include/asm/vmxfeatures.h
 create mode 100644 arch/x86/kernel/cpu/feature_control.c

-- 
2.22.0

