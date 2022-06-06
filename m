Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB253E755
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jun 2022 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiFFKPy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jun 2022 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiFFKPE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Jun 2022 06:15:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13278916
        for <linux-edac@vger.kernel.org>; Mon,  6 Jun 2022 03:15:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so7664815wmz.2
        for <linux-edac@vger.kernel.org>; Mon, 06 Jun 2022 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=p6Qo9UfxiwIYjwOuVFcdoRgJFy+paTc0SlKa7DM056Y5/CeT77kapKU2HQ4E8d/nRs
         m0jBi/gsZaz2+0D2eREuXndOtm8Q5CEmalM1+veg3XuKNgSzJm/AXU6tdLlgHyIkkr3I
         AOXBrKeHM25mWykMuujSr/BZtjAvMJjUu1zgmZu8/N/GnqGI8E/Xg6s/NDcEHQFrW6g/
         2oWSyqWVFXw6vh3SOp04o+/WgTYa2pk5wDpwqx35jWSZ6ocJ9gOXMmU2uKclceZUg5Cx
         2A49cH+Ohl24ZAhcgV5lC5Gz327tzP6Bszxx9s5rjUrtznjzi0CTza4aRHhNqcRfjh9W
         2jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=3U0AGumR7jckgSwsEz0BeXNmkVWfodxbnvZebjMGi9DMEgKQldOsJSCxJmGvqE1nIr
         NEVpC+w93CsuCfMp4BZA94Fyt+6QRQre0jG8X9mHRp2ozTHKm+PaKwFqYv3K9cEZtNYO
         23rph0q6iH8FmHdwtTKv5pJ1X3rmkjV0ouxBQor4GxPhKoYZwwlQbh0gOwhZTDRo2CaY
         y1+sW2RF1D4ZD31XG/rVjs9n4MOrFdfoNBR0nOim5HzDWr44/onOb0nbkmYPRg+vTuHw
         fxM8RGT/IK7tkSnr0bw6H5jbmVTO3wml9/BTQyVwufqb/ALsl8LhGLwHA3hO/P8YeejU
         Wl8w==
X-Gm-Message-State: AOAM533v8HJb4mbAbtN3gXYEYHlkj+FGR+uytRfyvMtstilzVe39c3jL
        sg2tsY8vjCkohYXvlmBh9TAQtC6gQL7JP+ifp/8=
X-Google-Smtp-Source: ABdhPJyJu+NN4S5jh2duXjJvePHjl9NZi8VYsqZnu+lut5QXAYs1X1knXkMufsBG3zfOCXZHQk/AwRzscVztSS7Q/pg=
X-Received: by 2002:a1c:f216:0:b0:39c:4c53:17d9 with SMTP id
 s22-20020a1cf216000000b0039c4c5317d9mr7565466wmc.160.1654510498665; Mon, 06
 Jun 2022 03:14:58 -0700 (PDT)
MIME-Version: 1.0
Sender: nnamdilamaechi@gmail.com
Received: by 2002:a05:6020:37cc:b0:1de:73f8:9f45 with HTTP; Mon, 6 Jun 2022
 03:14:57 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 6 Jun 2022 11:14:57 +0100
X-Google-Sender-Auth: ygaZpcRMJn1uG4B51merlUfci6A
Message-ID: <CAMpDM5LGh-SEaUYNfsLq0nqH-tj-MQxRm5Rj7CQA58UnQPL5yA@mail.gmail.com>
Subject: important
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
