Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679023EEA10
	for <lists+linux-edac@lfdr.de>; Tue, 17 Aug 2021 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhHQJkk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 05:40:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:36706
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235401AbhHQJkj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 05:40:39 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0A77740CCF
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629193202;
        bh=O8grwwL2ifdZnTVT+NKzhfJJRenRFaKSvMvVvpUkqxw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LY2VJqIbeVoh/lKViIxAuXUvye+Y7VhOvM1HeGB1J6LQSryix5syb14IM5EvNp814
         Bit+YERVKfZP4aRu087WY+Q9EYMhes4c8M2Z48Nbru1mmExa11tWCPKZA4Ggs+w7Gm
         cB9v641QxQbcJPw9AXzY3Y6I+2hrzHUqJejTs828rfH3jbx7EWG0OJWF5vTE7D8LZd
         mJT4R7i6qOukTd9DPvXAuS8Vtj8chDp8YpR/9/5ZpK8Uf2KCifgPZJb4c9aXdeZ0yJ
         140JyDsPQWZ/toMdEa8oOgVbDJSQRrpo5WK9i2UhpJoaB+ropzCjkZOtfeydxyC8US
         0DLPbONcg9Rxw==
Received: by mail-ed1-f69.google.com with SMTP id dd25-20020a056402313900b003bed8169691so4052841edb.7
        for <linux-edac@vger.kernel.org>; Tue, 17 Aug 2021 02:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8grwwL2ifdZnTVT+NKzhfJJRenRFaKSvMvVvpUkqxw=;
        b=da/ZQm1unRsfOH64KygFKpF1TSfZYZyoVv80Z5fXeUdk3r4IONSxHEh9UOtrz0QHEX
         CStSdL3kAbuwfy3lvnGyGNjqWPmjO3SRWjrJRr+K+SXhSV4/nOzLhwQsv0+utBbqUu0R
         fTW9/NxwNG99f912pnd7YR9cByswA0y+mGjGbjM6cqTrtj9ZgXq3jIIqIkTHeW9aeMPs
         bHOzjx/8wo2+cK5woBhW978bnHM7M3wP3NEhhdSREjv0QEClegWimMWDuolVfEepqEEz
         KdlmQ5oaSBlXOU43/kjYp9cXpWGKwK8sC4PTtegyE5lseqZ5I6oTPwI0fHXVYfqEHK1a
         A5Zw==
X-Gm-Message-State: AOAM530DGffD6EYcjnzkPalpQbfDvU6GR55H9nWVPKMvzyjzivhuhqQ7
        3Ieqf7i1jNWc39KY1yCe6yb8E/hXpkqDRF+WT4yNSgm/+RtIqQ0NBnzfLcBYmBzp63R+MXz3V5h
        yurGSIk2jHxfxjSZamy8P19Y/2KnSnZgwBXyV2lQ=
X-Received: by 2002:aa7:cace:: with SMTP id l14mr3209281edt.14.1629193201826;
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPaN9/+Xh9sugyxx4rCADXIJl5PW2HMz+txn6kA9UaH5J9NRz2BaR5d40ICG4bM9PnLwqk4A==
X-Received: by 2002:aa7:cace:: with SMTP id l14mr3209265edt.14.1629193201687;
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id sa21sm515667ejb.108.2021.08.17.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:40:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jan Luebbe <jlu@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: EDAC/armada_xp: include dt-bindings
Date:   Tue, 17 Aug 2021 11:38:07 +0200
Message-Id: <20210817093807.59531-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Include dt-bindings for Marvell Armada XP SDRAM and L2 cache ECC in the
EDAC-ARMADA entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be8e4af8ed64..ec75414db0ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6574,6 +6574,7 @@ EDAC-ARMADA
 M:	Jan Luebbe <jlu@pengutronix.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
 F:	drivers/edac/armada_xp_*
 
 EDAC-AST2500
-- 
2.30.2

