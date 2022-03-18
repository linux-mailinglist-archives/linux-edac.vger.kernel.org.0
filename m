Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F684DD239
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 02:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiCRBG3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Mar 2022 21:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiCRBG2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Mar 2022 21:06:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075401AFE86
        for <linux-edac@vger.kernel.org>; Thu, 17 Mar 2022 18:05:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p9so9705428wra.12
        for <linux-edac@vger.kernel.org>; Thu, 17 Mar 2022 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=G+Ih8OXqTaErwkXx8tAgouiwOH8oonESKJmHDOxag8pGmf7uNJUsfeMP4FgzRKxEO1
         6WEXA0YHdURDY9WxZKU9ZxRQJ3EQbz1M27NtZ9x/oBERSDD4chlJrS3VSOTUSr2mvnc/
         IcMDzqpr5xFcYZ6kEnzHZrjixYPumV8Libcx2PRKg86RKBnjjn6FYb1WZqMcQjG4dZ5P
         vWJn8S2Ibkm/GLXvo4+0V/GCKGCM97SwRKlVokl6YQI9Un8GeWLD8lMKE5USSchhzWxa
         RmhPmZPGtCPMvKNwYieEZCvdij1neP79dFmYsRhUkWb9h0kXyNmfSC+IUfiZo95f87iI
         iHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=THM3wU12c0f8SAqTaDxttp0dnI2MGBNpFMKhyoiMBi35yfWKmTe/vG4gNQ4ILqvN6w
         L2NSvGPvhiNUY+sqjQDqZPXK9JDmpu7Mf3zTo0+papxxFMnmycC66X9FLr5OlyeCrCaL
         vBG29mzKkjBnBsvN0Myi0PRlAqXR3W/9GZu9fRtwZGJbOM3FCflGEKEtJ74c1ngQZ834
         akqGkRPezQs+124aFzz/PBVSdb/BCDWSqKuIMD5InGatQQWrhayjl0GMLf7E2t/uZF/c
         L2pNoBV27RDmqtyGoFQKwXQk9BAzT5kl7AHTX4NyV/jv9QjnS/kVv3pqUJ5TafZDqeem
         Li2Q==
X-Gm-Message-State: AOAM532BaEBc1DoLYBtXds+c0eQ2SemGratqEKYCOvS78yXAv6c6QYD5
        omTRJSeQkG8ivFSOyC1kPSU=
X-Google-Smtp-Source: ABdhPJyP9onxYqZCSDBCQdMnVJ1mm/h68cp4ifS/1dpMN3pn6R84oMYwbnC7QpApA+xS6En8ItML8w==
X-Received: by 2002:a05:6000:156e:b0:203:d6e6:c475 with SMTP id 14-20020a056000156e00b00203d6e6c475mr6232506wrz.326.1647565508627;
        Thu, 17 Mar 2022 18:05:08 -0700 (PDT)
Received: from DESKTOP-26CLNVD.localdomain ([197.210.53.67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm4975809wrw.49.2022.03.17.18.05.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2022 18:05:08 -0700 (PDT)
Message-ID: <6233dac4.1c69fb81.fe3d0.40a4@mx.google.com>
From:   Barbara Finance Company <aondoyimatyoakaa@gmail.com>
X-Google-Original-From: Barbara Finance Company <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Schnelles Kreditangebot
To:     Recipients <info@gmail.com>
Date:   Thu, 17 Mar 2022 18:04:57 -0700
Reply-To: barbarafinancecompany@gmail.com
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hallo

Ben=F6tigen Sie dringend einen Kredit?? Wir sind ein zuverl=E4ssiger, vertr=
auensw=FCrdiger Kreditgeber. Wir verleihen Unternehmen und Privatpersonen K=
redite zu einem niedrigen und erschwinglichen Zinssatz von 3 %. Antworten S=
ie uns unten mit Details, wenn Sie interessiert sind. Vollst=E4ndiger Name,=
 ben=F6tigter Kreditbetrag, Kreditdauer, Land, Telefonnummer, kontaktieren =
Sie uns jetzt unter: barbarafinancecompany@gmail.com
