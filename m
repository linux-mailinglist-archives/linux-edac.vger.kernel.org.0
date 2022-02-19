Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916914BC8DD
	for <lists+linux-edac@lfdr.de>; Sat, 19 Feb 2022 15:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiBSOfB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 19 Feb 2022 09:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbiBSOfB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 19 Feb 2022 09:35:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29960DA1
        for <linux-edac@vger.kernel.org>; Sat, 19 Feb 2022 06:34:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v12so19312775wrv.2
        for <linux-edac@vger.kernel.org>; Sat, 19 Feb 2022 06:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Q3aoV/cLmnLwg58z2hJV12biD5inoZi1wHtPzY5nqyU=;
        b=e9OYxS4W5zYtAj9wrdp9GhFHj/apI0A9jyZAN0/9Bst1gqJzhMojeTpzdny8fXmnQQ
         p9S+5WRWiVHElCxPuvIeHwNuN9GXm9kAzEmgZ4t9O0XlOzwtUFsCDuRyKPr+zENfmAwY
         5cVS0FwZIhmS1RfnrS4xeYIf3iTNZJQoxhCoTa8iMXf7n4gKyXnuroBGCNLbzDnyogdN
         FmmCIEElSTAd+4gI4AO0MLflG0XV1ekK6VWg3w53uHQ0rZ4bvq27x8HV6pLQ9ITx8izn
         bAxEsuRZ3FVIu8PZxGdG3mTSlFjo/pHNSAavmvIx4o6qlKQdaR/sbglhwZSygj1PnWRf
         lQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Q3aoV/cLmnLwg58z2hJV12biD5inoZi1wHtPzY5nqyU=;
        b=gRQMTmf1rfprRjX7tI9/j0ulZMpegSeTuduRuNlAMFqeSrewSaSWAo+tGrLqYgxV/D
         RCSgWYDKLcdByWmW952vnGWygWJxeWUU3W3jTqWvHy4xKEDzcPNXsMMV35zuwAzTViSY
         AA6ahntre+glx6kGHFJTo0HVuKqSLLDOQ+bTxCZmwJbnK8xm8be9IFuzm4OKzzxlCd+N
         WsfN0CXnNbBrsWsTGYB7lGFdYREwlPfVZDm1Ru1Mn0UB/3wbdGxEkxefwWG6TqHErfV6
         LCODG7lr4qWAhSWAZC1R/ohb6bNYnxC/0RXOlXOrosKYvSwYH4LRLQ0uMOfuh86XWU/A
         MKeQ==
X-Gm-Message-State: AOAM532Q63H2fDTm6eblQZcq3L4QhBrxabMx6mm6N6xmu3reRmIubcS2
        x4VY6oCyVDeAIBc0nnomhLx6ouiLYi2OJpdfOII=
X-Google-Smtp-Source: ABdhPJwj22q+1hn+ssWA1zh9dDs83vvkd4Ikzr2gljjOtuVFdTylqOI3bveDjZ9OlGBbKagzTrLB+9X+tILLrp7bACc=
X-Received: by 2002:a5d:64e2:0:b0:1e8:e8e:c134 with SMTP id
 g2-20020a5d64e2000000b001e80e8ec134mr9664718wri.537.1645281280230; Sat, 19
 Feb 2022 06:34:40 -0800 (PST)
MIME-Version: 1.0
Sender: ms.ammiratalianlee11@gmail.com
Received: by 2002:adf:ed08:0:0:0:0:0 with HTTP; Sat, 19 Feb 2022 06:34:39
 -0800 (PST)
From:   Johanna Maaly Bob <johannamaalybob89@gmail.com>
Date:   Sat, 19 Feb 2022 14:34:39 +0000
X-Google-Sender-Auth: Ch_0F5a7OFIyGu8Pn62njMasiVY
Message-ID: <CAEPijZnF6TjJA00R+SmAdvCsfTHkNP2=9t_YNJDohEpFBaTvkg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Good day.
My Name Is Johanna Maaly Bob from Australia, I am very sorry If I
interfere into your privacy,i will like to get acquainted with you. I
will appreciate if granted this Privilege to know you more. Get back
to me  for formal introduction.
waiting earnestly to read from you.
Your From
Mrs.Johanna Maaly Bob
