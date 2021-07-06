Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716343BC5EF
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jul 2021 07:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGFFLO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jul 2021 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGFFLO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Jul 2021 01:11:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44990C06175F
        for <linux-edac@vger.kernel.org>; Mon,  5 Jul 2021 22:08:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y40so11104429ede.4
        for <linux-edac@vger.kernel.org>; Mon, 05 Jul 2021 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHDoPT8iUz2log46tTS8ycTrhaIwizguIXYNV7edjjE=;
        b=JCCtu2wGVFJZgpEGTqAkc+Hdcsyxk5AXJ5mP1deFHLUiIHDF/bvi7ZyonumSV0sgrx
         mdcJlXdIjdFtNWVPiiNLY1laaueR1B5lcsmBy3MnQ8nJq2zRefSRDb0uMGsI12Umtcyd
         /Yz3ZzCMiCFUWdrhNteirK40vSDbjeG47nKTdwJNkvm9e6RSMmAwpA160vAH3sg8jB8d
         VpNE3CBGzYQsbgxwnRpxqpMUmmu0MGHart5Y9QS4+N00Kv+VRw5qBqaYEd4ZlLf5aIyM
         1SXiTikEp5m5jwLQHflvVxE3wwgwgzk35j5oPcYmB5QfP90G6MnOatgLfGwmoIuK8/8A
         52yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHDoPT8iUz2log46tTS8ycTrhaIwizguIXYNV7edjjE=;
        b=UEcK/OxEbCZKBXaEorjGjLhSD2plLJVtdOxPsS7yffNrd+ZFr5bJVLF6AlyY1Mwbw5
         F5v6RoiSIIih8dIDs3UQqY0S8j95oQCxxr0jrSSy1j2Ak1xlNjf5xGmRWA5GgEosze37
         sYEiZcO+PvCSHaYUuSXEkTiIceJn6vPl4OnlmWGfT4qij2Gqpx4fmgwjdt6+2M9bo6Xb
         WYKdurZ4Pj32FjvNYb51gFoSwyabcN7hwjCuViS+n+ahUy6xKvqyl7r5IIMtAw4sZ8Aq
         /7/aCXb3w/QBU+xkuKPUnPvpBFfgVLbUkHuujHP+fu3ZJlWmQcT3yftGQwDOMF1l+AGG
         KeMg==
X-Gm-Message-State: AOAM533JQNfhIqbE+umP5m1bT9US9jGYGQoq+rCziAsxO5JCxz84zony
        XasBPLIILuhMIdZjlCFpqaIZ9QqWtA14Aw==
X-Google-Smtp-Source: ABdhPJwyp3Apk1jDojmHuKYLDDgPLaspCJ6RGNGPcbNEiWvYDS/C/H03DJrEohUbtDrkJ7c5bT6abA==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr4187001edd.206.1625548114831;
        Mon, 05 Jul 2021 22:08:34 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:499a:fc00:3532:1608:3da2:d7a9])
        by smtp.gmail.com with ESMTPSA id t11sm1967582edr.34.2021.07.05.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 22:08:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-edac@vger.kernel.org
Cc:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: Do not load EDAC driver when running as a guest
Date:   Tue,  6 Jul 2021 07:08:33 +0200
Message-Id: <20210706050833.9852-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Similar to commit f0a029fff4a5 ("EDAC/Intel: Do not load EDAC driver when running as a guest")

There's little to no point in loading an EDAC driver running in a guest.

Add a check in each of the Intel EDAC drivers for X86_FEATURE_HYPERVISOR
and simply return -ENODEV in the init routine.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/edac/amd64_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..cdb14575ef31 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3942,6 +3942,9 @@ static int __init amd64_edac_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
-- 
2.25.1

