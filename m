Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940407471B4
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGDMtd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGDMtc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 08:49:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26354AB
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 05:49:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso8681126e87.0
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688474969; x=1691066969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNuPDJgx2GdqBpIEifZmqZK6fZ2qXAmR592Qq8106yU=;
        b=OpHiS5xZ9e/VMAjP3Wdl8KL6dCQbiCu/vqD8LNmpRbIvzWCazcwE7xL0iZjoebeEsJ
         M3tjfh6uPO3MH0v3gD5x20EdQlq4iQH+3QPnURupAz20Faa9as30dthrmi2LW6mSdsWk
         aXQ0Mqln3oqQ9aklRLok6eifyDcPCfzPahUDilDONCBZW8Zmx1g2lCvNXYyodNBAVgyG
         MTDaxFF0xTpbXcUf9bQspFEVUejj1ynUU0+Kg86trEk6fazSKrtFrAhDfwpG7ksOA2vG
         24HN0G4U+LwVgdgwpkwegEEJjkfS0aUtSuVj6hAq/C9Ls+f4jqg5l+E6NA1o923zbk9a
         SocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688474969; x=1691066969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNuPDJgx2GdqBpIEifZmqZK6fZ2qXAmR592Qq8106yU=;
        b=c32fnRBchWLM+hGhFbIdEAfNU0AxyuALQOh1hUEYeJa8IKp1dSfPrDZkWtOH+5Vo6P
         0wrp6CRgjZfuWL19ZL05/M8jP6g3Hkseaiayq77tlMm4+8rS2itq/EhLQZGWksHU709Y
         5M3q1cSnrFevALfI0/3JA7h80U8l03svD6lYGhkLshuuXw9qsypq3hxnwGJZQHEltZ9A
         0CZANYD0aobi3Kb7IKxIJmWdWz7qrfSI1NLZ2LFNUeE7UU/2ls/dY8/KPgp/abJHLXyY
         nwxxnjAnnAmUjfbRSNE3UukQc/K3IsXDcW0+L3wb1XqYbmKrGSfOZJfUfc+S9fwLe6hI
         jX9A==
X-Gm-Message-State: ABy/qLbFfqsKDndCI4JF5hk0H2Vpq7/MZdn3ceLXmIOMfWY21BXqgtNW
        6AePt1M8hi9LfJjG7p6NePUAzhqPuO9h43ABzT4=
X-Google-Smtp-Source: APBJJlF7tgH35Y0RUbCd8OG9DhPv95WQyZCWbEhDobMqlTPWxXKBhQ/38us9NfUF9HOFUvR7sfNYdg==
X-Received: by 2002:adf:e8d0:0:b0:313:f2b3:af73 with SMTP id k16-20020adfe8d0000000b00313f2b3af73mr10169742wrn.25.1688474949314;
        Tue, 04 Jul 2023 05:49:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x18-20020adff0d2000000b003141e86e751sm12461124wro.5.2023.07.04.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:49:07 -0700 (PDT)
Date:   Tue, 4 Jul 2023 15:49:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/i10nm: Fix an inappropriate shift exponent
Message-ID: <af0b6cc3-1edc-46e0-a4c1-b8c10fd15ee0@moroto.mountain>
References: <20230704095939.119620-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704095939.119620-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Good enough for me, thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

