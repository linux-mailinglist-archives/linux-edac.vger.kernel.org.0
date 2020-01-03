Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D892512F983
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgACPIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 10:08:04 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:64874 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgACPID (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 3 Jan 2020 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1578064083; x=1609600083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iScVvzy4kldAidXvB46y5RqTW5IdFH/pNIveRmCeq3Q=;
  b=FTTDI0rCgGp+OrKxBHgUzBwNeOgX2d3me+ujoJNbodbZSgAtuqZe+s58
   hPJiThkNWXGG14Zb1Pk2J0o+bSGaNKO5Hg/cj53RwnYG5qj73aNPEBrRM
   UJACxdhnME44e0sE/suXQAeiMW4Ib7CKa7xx4IgTTw2cFtI2BmHK6riqW
   c=;
IronPort-SDR: F9CLz6y3IrEhyxpRN784UtvWMqWOfXnbUcR98YjCf+RgGtuAUdx/g2PjEgAKVmUDqflDaEAe56
 qDocL2B+R9DQ==
X-IronPort-AV: E=Sophos;i="5.69,390,1571702400"; 
   d="scan'208";a="11421828"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jan 2020 15:07:44 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 41B93A05E2;
        Fri,  3 Jan 2020 15:07:39 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id 003F7b23020436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 16:07:37 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id 003F7ah5020431;
        Fri, 3 Jan 2020 16:07:36 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 0/6] x86/mce: Various fixes and cleanups for MCE handling
Date:   Fri,  3 Jan 2020 16:07:16 +0100
Message-Id: <20200103150722.20313-1-jschoenh@amazon.de>
X-Mailer: git-send-email 2.22.0.3.gb49bb57c8208.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris.

This is the 2nd iteration of a smallish series with some fixes/cleanups
for the handling of MCEs. It should apply cleanly to your ras/core branch.

The first iteration can be found here:
  https://lore.kernel.org/linux-edac/20191217073414.GB28788@zn.tnic/T/

Changes v1 -> v2:
- dropped patches 3, 5, 6  as you already cherry-picked them into
  ras/core or ras/urgent (this renumbers patch 4 in v1 to patch 3 in v2);
- addressed remaining comments on patches 1-3;
- added patch 5 as per Yazen's comment that the SRAO notifier shall
  not be used on AMD for now;
- added patch 4 as a prerequisite for the given realization of patch 5;
- added patch 6 as an example, what else can be done due to patch 4.

See individual patches 1-3 for more detailed comments on changes.

I'm not yet convinced, that patch 6 is an entirely good idea. I've
still included it for discussion. If we end up not doing something
like it, we can as well rewrite patch 5 to be just another "if"
within srao_decode_notifier()/uc_decode_notifier().

Regards
Jan

Jan H. Schönherr (6):
  x86/mce: Take action on UCNA/Deferred errors again
  x86/mce: Make mce=nobootlog work again
  x86/mce: Fix use of uninitialized MCE message string
  x86/mce: Allow a variable number of internal MCE decode notifiers
  x86/mce: Do not take action on SRAO/Deferred errors on AMD for now
  x86/mce: Dynamically register default MCE handler

 arch/x86/include/asm/mce.h     |   2 +-
 arch/x86/kernel/cpu/mce/core.c | 145 ++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 66 deletions(-)

-- 
2.22.0.3.gb49bb57c8208.dirty

