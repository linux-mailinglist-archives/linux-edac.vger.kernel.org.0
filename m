Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB1164F929
	for <lists+linux-edac@lfdr.de>; Sat, 17 Dec 2022 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLQNy1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Dec 2022 08:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiLQNy1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Dec 2022 08:54:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC913F1B
        for <linux-edac@vger.kernel.org>; Sat, 17 Dec 2022 05:54:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id g8so1877373qkl.2
        for <linux-edac@vger.kernel.org>; Sat, 17 Dec 2022 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=Bcf/IpNhkIkvjrrV18ekUbkzLzWPiKb/BSpCiqSPyS+Hy0T+jp+2Awz4Xu+b4sIM9+
         +Md2riftzdFgZ6IkMhV2E58ddXLLPTlB5X21WPt+RzTrSwuj8yDrYt5FqQ7QyV4cBkQ+
         t2SwqEUB9MtiVxjWVuesIycn3AX447meKgrTXKKt+zN78fQxCJ+Zs2zFVHfDbjZ3+ScX
         eYZjoVn/Lu7otvbur6NnvB2FeBgDLoF704vjUqOYHTioBDgYL+ZFE8wv5+ZMVEcZ5NMo
         SCPVv++4AQqgu0gUXljrljS6kUqBpeoKWy7J//j2rC/APqZ30hQ7AuuzbUxcBDipibsu
         1gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=r415FqyhgKxVnc/LLmFtlBrz3m0EAHqEaaN6/CZXlGTvYKEiYU5GhbWY21KmLh/B/c
         YlRUorsnixQjXRuU5eukxBuBQ1VNi+BWn4NqyE05LyQpeD93mKIHZNXI0qVF4mWpp7kR
         BJ3gp9RFkJvRZlJJofSyI5ttMNrVsea9LeZBXddsYKCjaCuiK83IMhGR2eSR1OrM+MNb
         dTmnwNtl+VDiK5G34sr53O4cBG3s2UR1rvbVutbswBqh2RES2hv68nz7YzF4JhzrxP0C
         SXAsPPHCm4gAcZBselvNpkpPM5Ro4zs13PXljM+BJhBEmoJ6nSB8LKELTxwXO/Kk73ad
         OogQ==
X-Gm-Message-State: ANoB5pllXjl1RU9mwrGXMni6bmeKtOaD+mV9NM0ZNrCdZiOpS0ExR+KA
        LbpgHvxox+D+rPSHNyD/e4nLgQrrHCNDQ2N8XUg=
X-Google-Smtp-Source: AA0mqf4jekwUx9wzFmTUHH83Z+yXXm68rpCNB6VeAtRDHMCGkw4lcCDnn2ru8IsqNABG1qld33wfeev0HMZ2yHWfx7w=
X-Received: by 2002:a37:355:0:b0:6ff:1bf7:3673 with SMTP id
 82-20020a370355000000b006ff1bf73673mr1303360qkd.411.1671285265749; Sat, 17
 Dec 2022 05:54:25 -0800 (PST)
MIME-Version: 1.0
Sender: asfiss2018@gmail.com
Received: by 2002:a05:622a:38f:0:0:0:0 with HTTP; Sat, 17 Dec 2022 05:54:25
 -0800 (PST)
From:   John Kumor <a45476306@gmail.com>
Date:   Sat, 17 Dec 2022 13:54:25 +0000
X-Google-Sender-Auth: Ndou1dVeiAU8p6dMNOJIn2YTl1s
Message-ID: <CAMhHx7--QyK2Awg1=ayiGpBq3pRs4r-7Rug3H7Sb6iY9Un-UUQ@mail.gmail.com>
Subject: Kindly reply back.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,
