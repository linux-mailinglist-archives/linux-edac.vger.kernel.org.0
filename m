Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A150117C24
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 01:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLJAIe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Dec 2019 19:08:34 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:56151 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAIe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Dec 2019 19:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1575936513; x=1607472513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ObfhbJnesYSKLUKnizFOGo4UGmfq6qSeIpPjwf+Vj8=;
  b=fTe1UkzTz+9q9t20qKOL+r4pgyppxFoNVof/l2RcGhB6jhaRblrrTUcZ
   DUJRD3oZz88JFpRKq9NiK0KhDCkj5LW95UNTdUzLAjpk6hf2FGrZ9pc9a
   jwfmoXXuwIMT7z8En5QIeC8Ubi8/FLVxwOWBoBZot05TaEH909hiXdirn
   0=;
IronPort-SDR: MwarwKjk72zhe/uq0vsRp2RvWq0sHEppjVD+ReNmvecDtUkpVXTCyILG7qGvDOaxWmWLiv5NHF
 dfmIvjvNotcw==
X-IronPort-AV: E=Sophos;i="5.69,297,1571702400"; 
   d="scan'208";a="7765080"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Dec 2019 00:08:29 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id C5128A24BD;
        Tue, 10 Dec 2019 00:08:24 +0000 (UTC)
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id xBA08KNK018186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 01:08:20 +0100
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id xBA08HSV018176;
        Tue, 10 Dec 2019 01:08:17 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 0/6] x86/mce: Various fixes and cleanups for MCE handling
Date:   Tue, 10 Dec 2019 01:07:27 +0100
Message-Id: <20191210000733.17979-1-jschoenh@amazon.de>
X-Mailer: git-send-email 2.22.0.3.gb49bb57c8208.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi.

Here is a series of smallish fixes/cleanups for the handling of MCEs.

Note, that except for patches 2 and 4, the patches are just compile tested.

Regards
Jan

Jan H. Schönherr (6):
  x86/mce: Take action on UCNA/Deferred errors again
  x86/mce: Make mce=nobootlog work again
  x86/mce: Fix possibly incorrect severity calculation on AMD
  x86/mce: Fix handling of optional message string
  x86/mce: Pass MCE message to mce_panic() on failed kernel recovery
  x86/mce: Remove mce_inject_log() in favor of mce_log()

 arch/x86/kernel/cpu/mce/core.c     | 59 ++++++++++++------------------
 arch/x86/kernel/cpu/mce/inject.c   |  2 +-
 arch/x86/kernel/cpu/mce/internal.h |  2 -
 3 files changed, 25 insertions(+), 38 deletions(-)

-- 
2.22.0.3.gb49bb57c8208.dirty

