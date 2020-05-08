Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E011CB84B
	for <lists+linux-edac@lfdr.de>; Fri,  8 May 2020 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHTaU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 May 2020 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTaU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 May 2020 15:30:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075BCC061A0C
        for <linux-edac@vger.kernel.org>; Fri,  8 May 2020 12:30:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k19so1158907pll.9
        for <linux-edac@vger.kernel.org>; Fri, 08 May 2020 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+8zSuS0S+a6U9nv66+C2u77Cjfcmm9tozvBS7DhkCQ=;
        b=tmr8aqUveTBnlQDblMjKRB0AWuN8KV8tw9FY6Qa2lSGQPF5+I5ns/CzQQ4N7QviSlH
         iqyyAXTkAPaqxciyCggJ2LCm90xWR042EpHQ72PxAUGXJYOYsv+1eV+fvx0h+WPcdgXG
         fXN6CpQKRMEIh3Sr0xepm0UgsjE4+2kquAWceg29Jdv+royVE81r0e0J5yQ0uBE6umzY
         lgRdbmgu9rQLS8aJtL1sTbDe+jix1lLBncKY+BtcYIAm4slw3980OzU+QkF/HoV9K85s
         ypGBFMpsbvD7KWH4f7efJjRourMwJOLkO9Y5ZbSFooOSaxRBMgxgy0QsKFqyeOAP4hdN
         YUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+8zSuS0S+a6U9nv66+C2u77Cjfcmm9tozvBS7DhkCQ=;
        b=R5AYVuqrouprwP+WRwvQVyWsJqvvy7BeiKSGCpzWMpoH4pkPMuLTtxxGGsdKUSsJCq
         qObKSsxhMctLJE56H+zB6W1gMdb0ggg5kOxKmvB9gmx8qcGULt535rsU2bx5M9/iEu0w
         7bT0pLZO8XfCzC1f7oxAG5jddz5l5/Nmj8pUl05JyrL0mVlHXTHALqW1GI3UfQX3aAXJ
         TGiI60/J7yHzhvGqwvpBofjJA8Mon6zxjtn6pRXza3mTNF1RgHh9FzboueH/k44moZzy
         Xt/o7fAwhjio4KVBtIofpwAF0RdiGFPpsQVJGgKHYO1GiZVxKdHM0r/IAisILy1TKr1F
         YKMg==
X-Gm-Message-State: AGi0PuaTOcOkrYLYt6kqqA97F7CO4eUcD3kwAuEQZpkhwRFApw6lDJ3a
        QFhPVjgHj1DjCRzeVWLuTvY=
X-Google-Smtp-Source: APiQypLKtfRy5pAlnSWwbEycl/MfF4kWyY4kJ74UBFU31paR5c3rIO9w+TNnqV66VsPmGn/zJiaTzw==
X-Received: by 2002:a17:902:bd89:: with SMTP id q9mr3808221pls.161.1588966218861;
        Fri, 08 May 2020 12:30:18 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:4e0::2691])
        by smtp.gmail.com with ESMTPSA id y7sm2560676pfq.21.2020.05.08.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 12:30:18 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     mchehab@kernel.org, linux-edac@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Fix system header includes
Date:   Fri,  8 May 2020 12:30:16 -0700
Message-Id: <20200508193016.3951932-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use poll.h instead of sys/poll.h
Fixes
warning: #warning redirecting incorrect #include <sys/poll.h> to <poll.h> [-Wcpp]

Include limits.h for PATH_MAX

Fixes
ras-events.c:359:16: error: 'PATH_MAX' undeclared (first use in this function)
  359 |  char pipe_raw[PATH_MAX];
      |                ^~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 ras-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ras-events.c b/ras-events.c
index 511c93d..400e740 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -18,13 +18,14 @@
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <sys/poll.h>
 #include <signal.h>
 #include <sys/signalfd.h>
 #include "libtrace/kbuffer.h"
-- 
2.26.2

