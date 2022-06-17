Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9354F64F
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jun 2022 13:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381162AbiFQLHS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jun 2022 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381101AbiFQLHQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Jun 2022 07:07:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144A6C56B
        for <linux-edac@vger.kernel.org>; Fri, 17 Jun 2022 04:07:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w2so1010731lji.5
        for <linux-edac@vger.kernel.org>; Fri, 17 Jun 2022 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=pFedS01kBZoPf8w5+XJZcYZ94+8/5BPGUMxxnwwcOpVYITA5QWxlJn7CMxhAI+ggn0
         /n/28MyUQZTSa/tie3dRsmPvE6NX0vXVKx9GcLBynkwRm7La1SLF/jZ5GK37A9iYVslj
         cxRwouHTo6i4mfGOTyJ4x2iJ0wTWYK30mjugdDqjpN9rYfygPrW9NZ0NWOyToP1CWp46
         jNS7rLQYL887bhFBWjWHc5O4KaUdYzHyX312OjiTsq7uRVOIf6TRRgIWJ/y7caMT0Xuq
         B8ExJre+ZX9oLKGDOuZypV3MojECtLAOVpHDZkChLfLTJ8bAgTQGLFSFyIawJRZds+UR
         mrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=m9+Ot9rhBeKrrAJnMKhkZ4nWaL8+MLh6y+plupR+UTDPh8ybBiA/Me6H1WoVBG1Tpg
         fYtmKZQ0NM9o7o+ivAT5UeCOsMbzBfk7ZutVi2HTylYcg+3aeAuRAVJ8BkU1YgdeU1qZ
         zMk2VFv3XQxY6NVhWEgeMW+tllSjNe3f+JTIPmHCmlr6FlCp4MBNCic5qNvrH5Df7kiG
         5MXq1HYPjhivYLcUzV6XpfxWUrwYNuyey9Rp9uUkq8k3D7x+VVzEm7JMUODrcXRzmJIO
         oiAJSfVKTddZg9V7Bf7G0PzmNYWPXTH8Xbf/P9iXeGdCPhtfkIH54yA/zb1btnNO19A/
         KM0A==
X-Gm-Message-State: AJIora+EFgEuZuLYCanUhzV2gmh34NWO2wxH2YAvE4Zhpqh6flnWwYAt
        ZUtfyiT7Fk8mJIpbgicl/2bLAeQymdmk1eWIjB36A5EqDjR22j9tUKs=
X-Google-Smtp-Source: AGRyM1urbzChfLmiDMc9bFbg6bdjvB/HYUWIimmBCgu3hpulMNQeMq2SygPR7Z1ddcVc/lcKEnhtY/mkjjoZrMogRKA=
X-Received: by 2002:a2e:3a18:0:b0:255:c053:1726 with SMTP id
 h24-20020a2e3a18000000b00255c0531726mr4746217lja.316.1655464032670; Fri, 17
 Jun 2022 04:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:07:12
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:07:12 -0700
Message-ID: <CACKGxpxo3tFpcQ2Ff60d2jb9EYqr8nW2BCHOZnDrUcXOM1k82A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi   are you available to  speak now
Thanks
