Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD20311E17
	for <lists+linux-edac@lfdr.de>; Sat,  6 Feb 2021 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBFO4a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 6 Feb 2021 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFO40 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 6 Feb 2021 09:56:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF83C061221
        for <linux-edac@vger.kernel.org>; Sat,  6 Feb 2021 06:55:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a9so17670781ejr.2
        for <linux-edac@vger.kernel.org>; Sat, 06 Feb 2021 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=AR/QhrPQruWll6eXF7MZaSUhJJFfa6rBSyVIOpyZ2HPX2RoOBvbUAMof8f/CHjKckV
         pAaFVZoxGf/yyTyPFLfc1oYaqEKcbvnO4EuldJzhh8ESiAObihdB5wASPw8MGjs9rJ15
         5qJUSkFco5MeKyt3/fxM/lPljsbSjxVYoyitW13LVc+/OV9QDz1ttXK5hx49orPFFzqm
         +uqjBhxsMfO7dT/VvJLyTUNCzOjPyK0oTSpu99C9Y+OZ5Z3QwR4iTbhwB3S5ja13uiqx
         eo6dDFPExyJax7R7MKEm5bHfHEcKWsgwhk8QvFsLAtoYLcz8ViVjoy/yRvG+BkyRrYV1
         Pkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=YA7FHmNTPm4gGTwJd4OV7Pk99n2bz/+1DuiM/VYPPAo5z2c2tCx50o2k6DE1tsSh6S
         IDoKEJXi7Rka49TpIbrSjkzqVu+OJ2q1UNVDSwvKQvhKi+njdVJsCABrRvC89wact+zT
         foiWjsz1JCrEuxoCpzLWj5EwO3Q+5TB/ux93bL6aBLMAPcD81qO5EFqhZXduSRg9JKmq
         U9bP7f/OCtmpwpu8rSjjk1V8X3+MnW3ypSlHzhrbh1vorQw8EbeTTR2AxNErJ35z5oLs
         /6YSTB8tsXUnlDGOuEjXbRQQwwzfG7OClV8KPAP+4Wyz1CrmHhcTNqvblMsCbhrue4mb
         2DQw==
X-Gm-Message-State: AOAM532YQzM6ZZPpLAqlV5JozHOXOQhaWLm1CxGepR2EIPAGpRyHrIeS
        AY1lNZgeshQ3sJJf8AfxzMh2u+zcSNPR3CsCQEUJOHrWp68=
X-Google-Smtp-Source: ABdhPJx37n8ny890wOvPLPmXJP8eHNacvPPOQ8GSuwAST0dU5XsxdHmzDpoMVVQgeGPzyxAMfHzhNKGJlKNXQkY/4T4=
X-Received: by 2002:a17:906:408b:: with SMTP id u11mr8882036ejj.299.1612623352562;
 Sat, 06 Feb 2021 06:55:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:55:51
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:55:51 +0100
Message-ID: <CAGSHw-BYzm1g5x=+4aJ7LJUVhK-8ZVgtmMKo7Wr-2YYP0tUObg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
