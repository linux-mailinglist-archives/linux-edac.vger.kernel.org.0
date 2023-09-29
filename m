Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972297B3A55
	for <lists+linux-edac@lfdr.de>; Fri, 29 Sep 2023 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjI2TAS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Sep 2023 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjI2TAR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Sep 2023 15:00:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917281B8
        for <linux-edac@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf55a81eeaso110611215ad.0
        for <linux-edac@vger.kernel.org>; Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696014014; x=1696618814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=HmUFAh0zkPL1XTlG3DZ98Lpg/V1SZuEoX3aE4Kq4pkbqrC/H5wIzMA5Ey8VsHEKpWi
         yVIgAWX00Y05jmBg31jtYE0BWtl1wsLbgOvemDcQMYAbhvOv2CroSlN2gc/aC1DsIZvx
         S5UPmWcHXmwWMUaXbAqPSB6V5YPgKaXCe/rr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696014014; x=1696618814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWeOES3N3vd1Zvv6AwyKn/S5xF8EcGUaGZeIj8wdjdU=;
        b=uupEJsBS1S3DJ+o5HB1X7M9hxXQwE5QdELkk9STIBYu3d4D/vPMu61+iQXPKPjgGdj
         2NYULMPnLhan5TxbMfk8L54FQns2hQkL4LHArZHtQh4thT0j72epK5/e4KEw+r0Fj18h
         8TW4EbQDxhASWsAUMYQvnIg4kfdRuxbh3A//DMP8fadT/Fjp/pmpfuN1dNuKPxAAr799
         XgAsJM5qpbdRuvodbpqAzV0DfwMtCbIuScIYveV9GIN9yvcGVNfeJD6n43/NKm9hjFEd
         GMvA9mUJcbyTmSyKUF/XjtLk7D5xbpQu4p/WFj4K2FGwMrI3W7a3VDAaNeUQOWb5SUl+
         V/OA==
X-Gm-Message-State: AOJu0YzHNWPBwY7wNoxbLLILq1kyqtAIfDMSfnzVA229tLEXozPEsUtf
        95siEB3sHDX8N25yq58J0PINvg==
X-Google-Smtp-Source: AGHT+IFalx0Un4U0EyJJTXitS7mv7fMxN2PPC27u8ial/BdekWtfArKvqJ9zOOkHTfSVfLFaLHHVqg==
X-Received: by 2002:a17:902:da86:b0:1c6:bb3:29e6 with SMTP id j6-20020a170902da8600b001c60bb329e6mr5492246plx.16.1696014014059;
        Fri, 29 Sep 2023 12:00:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c73d829fb0sm3014497plb.32.2023.09.29.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:00:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 12:00:05 -0700
Message-Id: <169601400133.3011505.5557490241780172507.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
References: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 18 Sep 2023 07:47:29 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We've already calculated bounds, possible truncation with '\0' or '\n'
> and manually NUL-terminated. The situation is now just a literal byte
> copy from one buffer to another, let's treat it as such and use a less
> ambiguous interface in memcpy.
> 
> [...]

Applied to for-next/hardening, thanks! (Subject updated...)

Take care,

-- 
Kees Cook

