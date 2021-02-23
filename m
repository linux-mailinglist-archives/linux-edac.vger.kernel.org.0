Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBE322E7C
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhBWQNc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 23 Feb 2021 11:13:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:41789 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbhBWQN3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Feb 2021 11:13:29 -0500
IronPort-SDR: u7jWhP7OeCTUQES3+gXGNm+84iVnmmGO61Of/H4UGBQIbdQBF9/Z04Ll2yBNaIHYctmPW83epB
 2bo+OJgLR16A==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="182374287"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="182374287"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 08:12:44 -0800
IronPort-SDR: mvHRXc1c3Xj2Zc6CYVHAzBQZFfyPMARad72ImXKUsqxBxDHW2aN71TbrhiIa6H7+fFCHZNp2ln
 fxxOfM/DET5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="430825957"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2021 08:12:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 08:12:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 08:12:43 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Tue, 23 Feb 2021 08:12:43 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>, Borislav Petkov <bp@alien8.de>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: RE: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Thread-Topic: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Thread-Index: AQHXCMs4S05nMoSMUUKxBUNxuC0xxKpkECSAgABdTYCAAAH8gIAACSgAgAABOoCAAAPaAIAAEKsAgAAPioCAAAF8gIAAA6uAgAACzACAAOWwgIAAeZAAgAAD0QCAAAKCAIAAFsmA///Hv4A=
Date:   Tue, 23 Feb 2021 16:12:43 +0000
Message-ID: <9232988079334ab8801cccec6557f9c3@intel.com>
References: <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
        <20210223102755.13cbdffd@alex-virtual-machine>
        <20210223094300.GA26060@zn.tnic>
        <20210223175640.5708c7ed@alex-virtual-machine>
        <20210223100538.GB26060@zn.tnic>
 <20210223192711.0b517745@alex-virtual-machine>
In-Reply-To: <20210223192711.0b517745@alex-virtual-machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> What I think is qemu has not an easy to get the MCE signature from host or currently no methods for this
> So qemu treat all AR will be No RIPV, Do more is better than do less.

RIPV would be important in the guest in the case where the guest can fix the problem that caused
the machine check and return to the failed instruction to continue.

I think the only case where this happens is a fault in a read-only page mapped from a file (typically
code page, but could be a data page). In this case memory-failure() unmaps the page with the posion
but Linux can recover by reading data from the file into a new page.

Other cases we send SIGBUS (so go to the signal handler instead of to the faulting instruction).

So it would be good if the state of RIPV could be added to the signal state sent to qemu. If that
isn't possible, then this full recovery case turns into another SIGBUS case.

-Tony
