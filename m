Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136D4B148E
	for <lists+linux-edac@lfdr.de>; Thu, 12 Sep 2019 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfILStA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Sep 2019 14:49:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:46388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfILStA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 12 Sep 2019 14:49:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 11:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,498,1559545200"; 
   d="scan'208";a="184886027"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2019 11:48:58 -0700
Date:   Thu, 12 Sep 2019 11:48:58 -0700
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
Subject: Re: [PATCH v2 4/4] x86/mce: Add Zhaoxin LMCE support
Message-ID: <20190912184858.GA26892@agluck-desk2.amr.corp.intel.com>
References: <5f4f8dee1fb24d38aa0ee136c5e98c72@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4f8dee1fb24d38aa0ee136c5e98c72@zhaoxin.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 08:20:07AM +0000, Tony W Wang-oc wrote:
> Zhaoxin newer CPUs support LMCE that compatible with Intel's
> "Machine-Check Architecture", so add support for Zhaoxin LMCE
> in mce/core.c.

Your mailer included a header:

	Content-Language: zh-CN

which seems to have made my e-mail client (mutt) very
confused when saving some parts of this series.

Unsure whether that is a problem for you to fix, or an issue
at my end. Posting here to see if it rings any bells for
someone else.

-Tony
