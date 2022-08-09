Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB058D196
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbiHIA6o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 20:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiHIA6n (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 20:58:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8731BEAF;
        Mon,  8 Aug 2022 17:58:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s11so13254486edd.13;
        Mon, 08 Aug 2022 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vivogvUanLqf/+xeQKp88FPAZ7ZllTwvRVZ+ptlXqkY=;
        b=j1p1Ia6v5EBGIpl2oD43/FdFRIRl0/LQ0wJc5fito9bY1la3rf9Tu1Wg16hgsDyNuD
         8scWmOy5uXiq49/X8WWES+D8qWH0fKiXQzYAWhWrhfFWBrGQUe8jSyy+gJ+7AfT9p2Eh
         Y3VemtSfXGy1bjWMmP9W14bodaxRwGdHNzry4Ue0GGCOQjuQf9Jm4eLOyH4sn6fQbXc8
         ATfqgKHeQ4D+N2oP923BnzqNvnEuNmMGQlDF+F4mgDMfFL3K+CjfdCmNhQrOBWs/fk+0
         YAbJcqNUgvy1C0cTFzexI2xNAIyniRaAXcgu/rtcCtGPywAjmY/pM2mg2qE+17KfVhO5
         rzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vivogvUanLqf/+xeQKp88FPAZ7ZllTwvRVZ+ptlXqkY=;
        b=cRShuSFv4NJ+erS9mNAgHY66AgaelaMZn8hoc5CEVerdj990Y7qqW85FemHpHcDYBd
         eU/OIzKtvBzMxPrIbZFW/FKaacUYRYaHo+0IAwwAUE5N4jZSGT6WJtzz4ESadPtJOhrT
         uOVJToO/KH68VScORotqSmEv2tZixaEoF1KGbL/XFzK0dYSdJl7Gahb+tocbNAbgTKVa
         GJWWFCDWlbGeyvQI8gXJ6mmU7KTW+CGP9Drcfrf2PK5nr4AFxr6MlChHTxKC7vcqJbkS
         PV7OCOHoay+eNvcxTdqrWfzK9RpkPwEN+o21xUOGDSQNNCLZMQV6TEt3MP1spkv041u/
         /Ykw==
X-Gm-Message-State: ACgBeo0cVMtfZ51V9OibSnMRh4zd72LPUI3KmS1BuF+QSf5OKGOnWVmA
        W19dfZL+vnlGNdPE+eeR/cSVulsya9FQkL0imVw=
X-Google-Smtp-Source: AA6agR4u+PwcE5Rt/E2Iw8gTIqyGOStyp3TcXeqQ7JtzNfC9nIjngdT+CDuIWjdizmLyndyNQ/e5KbErR2lBatKjaa4=
X-Received: by 2002:a05:6402:428c:b0:440:8259:7a2b with SMTP id
 g12-20020a056402428c00b0044082597a2bmr9071167edc.329.1660006721482; Mon, 08
 Aug 2022 17:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084340.2268-1-ctcchien@nuvoton.com> <20220610084340.2268-2-ctcchien@nuvoton.com>
 <YrCi1fg+mUPwZ7sX@zn.tnic> <CAHpyw9dkE65vUiyG-=gvQHGCZ-=nm1AX2EwANGPDAJmfn7sZkQ@mail.gmail.com>
In-Reply-To: <CAHpyw9dkE65vUiyG-=gvQHGCZ-=nm1AX2EwANGPDAJmfn7sZkQ@mail.gmail.com>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Tue, 9 Aug 2022 08:58:30 +0800
Message-ID: <CADnNmFre-rhBYKtqFs9JEgDYj8iAr5YZ0qs4MqXRczsL1Z65OA@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] dt-bindings: edac: nuvoton: add NPCM memory controller
To:     Borislav Petkov <bp@alien8.de>
Cc:     Medad Young <medadyoung@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        CS20 KWLiu <KWLIU@nuvoton.com>, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav,

Thanks for the review. I'll address the problems you have mentioned
and send v13.

Regards,
Marvin
