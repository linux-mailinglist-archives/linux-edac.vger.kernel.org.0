Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4566D9CD
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjAQJZZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 04:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjAQJYw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 04:24:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8171E5D4;
        Tue, 17 Jan 2023 01:23:13 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so73806977ejm.8;
        Tue, 17 Jan 2023 01:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yTS8WZ7b7VFDo8nye8k9pelewOPAxy8Omflt0xq5o8=;
        b=qgdAaSckTld8p8lQJOo4kGuY3T4C9u8d3t7peDU+fhIHYQ1OzGVHqYA4bm+5fRtbc/
         MO/7D2Fws6uCBF3/NFI7ZeF6co1oK1pIBXOzzydc7xBOLps8fmSpBIPONik7YzrbAn05
         x7WopuZtxM3l0abO3FnDMqUhtGmOhJxE+/S6HQE38Tkt0r4R0GH+K9STBUrdGDlfDsmq
         xWaaFrNsHNZzV6Pq0FCxg4ACC5XefQnpSGm1iRily+d0fGzLZslkYFLkKxhDov/m3irv
         fouly+YKX7lJVGXb4MCZbXdlJZdLZidht9RpYwftO2k8MPCJ8ev/dUMIdaCz/ValeSoG
         z5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yTS8WZ7b7VFDo8nye8k9pelewOPAxy8Omflt0xq5o8=;
        b=IDeKEiXKSx81NIhHFQMv3Ky7fK7V4TC3AtFiKQPbH4mBoJ7ZWFjEjWc1XJbYTgCNvN
         Jt2CStQVEbx7aOx/zZouqqdOZ0DzJI5Zo6Sy7M5DPikGrRrUhxwmKFi40ax+T7GV2Qnc
         s4Aog+oOPFSROvBAyhPp+C8iPh+6N6stusXH6W1aRCK6t4ILBRMHwqGQqBtB3cTPXqwu
         satVXm8dMv86naPqA58++aBm3i7S5KESwPPbwSULpDQ6gV/W8vnE9QwGDWsrQPEb/OdT
         yHB0L0qNZpUkEArqkx1AdsCL8BelC4H89lZytxESWz16MCKF1XEgLq1pJkTwyWORsa1k
         9yKg==
X-Gm-Message-State: AFqh2koSjA5RCfQI3QCjJXuNU2/jy9HPPt7KcL071+Bb/Dky1V0jGul2
        3ZQd0SXGONRDu3+elNHLu1gJLFqvwkk=
X-Google-Smtp-Source: AMrXdXsTS1iYWklNhMj3sHt+9xfuRTRiMQuLqulCASKn7OviJJySXWOr0HEp7yr37d8tkNlHolQE+Q==
X-Received: by 2002:a17:906:b893:b0:872:1a0f:173e with SMTP id hb19-20020a170906b89300b008721a0f173emr1962026ejb.68.1673947392470;
        Tue, 17 Jan 2023 01:23:12 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id kw4-20020a170907770400b0084d397e0938sm11544207ejc.195.2023.01.17.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:23:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 10:23:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Avadhut Naik <avadnaik@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
        yazen.ghannam@amd.com
Subject: Re: [PATCH v1 3/3] x86/MCE/AMD: Handle reassigned bit definitions
 for CS SMCA
Message-ID: <Y8Zo+hj8qxYpZdAl@gmail.com>
References: <20230116191102.4226-1-avadnaik@amd.com>
 <20230116191102.4226-4-avadnaik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116191102.4226-4-avadnaik@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* Avadhut Naik <avadnaik@amd.com> wrote:

> @@ -178,6 +178,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
>  	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
>  	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
>  	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
> +	/* Software defined SMCA bank type to handle erratum 1384*/
> +	{ SMCA_CS_V2_QUIRK, HWID_MCATYPE(0x0, 0x1)  },
>  
>  	/* Unified Memory Controller MCA type */
>  	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
> @@ -259,6 +261,17 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
>  
>  	if (c->x86 == 0x19) {
>  		switch (c->x86_model) {
> +		/*
> +		 * Per Genoa's revision guide, erratum 1384, some SMCA Extended
> +		 * Error Codes and SMCA Control bits are incorrect for SMCA CS
> +		 * bank type.
> +		 */
> +		case 0x10 ... 0x1F:
> +		case 0x60 ... 0x7B:
> +		case 0xA0 ... 0xAF:
> +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
> +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);

Why are we open-coding these types?

Why not use smca_hwid_mcatypes[SMCA_CS_V2], etc.?

> +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
> +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);

Ditto.

Thanks,

	Ingo
