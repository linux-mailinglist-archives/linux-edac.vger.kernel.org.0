Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128E53E7C3
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jun 2022 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiFFK0D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jun 2022 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiFFK0D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Jun 2022 06:26:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E73326CA
        for <linux-edac@vger.kernel.org>; Mon,  6 Jun 2022 03:26:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l204so24842788ybf.10
        for <linux-edac@vger.kernel.org>; Mon, 06 Jun 2022 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=bBATiigfTLWPh2IW0Zax14BaTbN04lEg6SwgPesQEhoxij7a36xEi34p2PMvdnfiQf
         bKdctyM7WT/g+KYLyvSxSKBOotCKC4mQOFWGpsg9fGBt3NAw+7Pf7jr3Sz+Q44nQEOQA
         ihWZOL6bemU6EzaBtAt+BJcvTdPdSjvQvpdbsqf2IhWsitT0aVd74hJmd3uX8kTQ711b
         k+jHAL5jQs/fCxwEZW/SQ89Z91/zzMzO2M4/Y/z8KjoXDJAsH9BrfjXvlZD4NAjhD+M5
         YutZiAo2rE6f0RbBkLdotdixK7Vy4y1CQYpa6Wdp0s9F9UmCcUwgU4vtFumBfkuh+0oL
         NAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=gQY8tdIn6LqKomNZse6SzZBoFd7g7VvXRKIJ1/IueMsvTxyztXl+usST67smTCn36x
         Zpd1ttmdOkG/RH+96j9ebxkqULUuOcTP+dkJGxru5kp4f9XYEndXNSsLlgX890odSHVP
         6bB6QW8DK8LIMQoOG09j6/F5oDdNmbm2KjzqPzeZLFwF5ECdFQkyow7Hk2wqBtLYzVbS
         IG8BKJdEc65kZhKV9N3P94NuU89b+Ep+sScXlRQm55C+Em16oz34mw67zadjzqJsg1wM
         UrT+KuyoR/Z/W4qMeGL5xvR3w6Ug7Dg9WkB0XX5r64swRP1dOE/vWSJDLbbWeqsaJgSj
         xsAA==
X-Gm-Message-State: AOAM532s7xaJlUvAbBXQqrKOtwVQZ6Zh3q/U4Rm+FpsU3+ozHVUfOnpD
        arAMO/Dvqxz6B1U0vsie37g9UIPcGDbm4gvPaHE=
X-Google-Smtp-Source: ABdhPJx68/Wme7odVOGAyrkk7wLaQjz5kDLnA1JdO2d1iiNI9n8cCraF3Y8NOKmHqWoRfltggm9fKiyxiFmhVAqViGI=
X-Received: by 2002:a05:6902:1202:b0:661:821f:ba94 with SMTP id
 s2-20020a056902120200b00661821fba94mr15686622ybu.133.1654511159804; Mon, 06
 Jun 2022 03:25:59 -0700 (PDT)
MIME-Version: 1.0
Sender: larryamaechi558@gmail.com
Received: by 2002:a05:7110:580d:b0:181:98ad:7acb with HTTP; Mon, 6 Jun 2022
 03:25:58 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 6 Jun 2022 11:25:58 +0100
X-Google-Sender-Auth: D1U37jT5iZ9Gb9VQdY2HoGBKe_U
Message-ID: <CALHLwjWsKpRthP_V9EVnPdjnZC0PgLj7fpvqgbnu7o7BzXL0EA@mail.gmail.com>
Subject: INTERESTED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
