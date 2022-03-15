Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D814D98E5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbiCOKiF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbiCOKiE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 06:38:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73754ECD7
        for <linux-edac@vger.kernel.org>; Tue, 15 Mar 2022 03:36:51 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 527023F603
        for <linux-edac@vger.kernel.org>; Tue, 15 Mar 2022 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647340609;
        bh=TEi9FBbJRZ98ujLdP/Lz9ClVk8P7w5er1AYT1Hftf6A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MfwiNKli0xUAvhwoAWkyB2P22xn0Zd7WiLuT0f2DBv7yZ8vKvUNMocqO4NypKd/m2
         KhaE/vtty+f/XTK/lSBBdUD7HaiES2sdJewEY5l00TQXlcUEM/xic2KhdbL30/LHn4
         iV/0oQHUMONKcY8WE4nFDbMKyGazxcjiPdiyLDuKRBW7rir7JUWc91jiRobP6FiClR
         7L1Qw7eC7upNWlhP+NBZ04Y/raoHHfbnK2J4puxvlT9w7VYIQxkH9UE1qqBNiB6xNs
         8lWK5+zQjH0qdZrLucovfpuHZqvmBkHrryebCZ8KKGA9/KT5sDkAN3cDOnA62szP+D
         Grc+77YMKCLlg==
Received: by mail-ed1-f70.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso10340816edb.17
        for <linux-edac@vger.kernel.org>; Tue, 15 Mar 2022 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TEi9FBbJRZ98ujLdP/Lz9ClVk8P7w5er1AYT1Hftf6A=;
        b=m4zkNsN/RTuDziDIzSxuCk6FSRC0Zxi7sFBsZBl7Nd4Qa+m8PxPFHTJ0l1ZNmLPas0
         UBlnDO3gZ+V+bSODp/Bj7szNU9FFxLZj/JRYthpX1fOwopBXnW2ypZ86M+IlQdlVNn5l
         v1EpOj9PfS1EEMB4dPbw+QwRH6HX+Ah6RlALQNd296Y6RySWuUrqTdw5UqpxqZb10eAx
         Ru9ylq8/uBJD70rn/+23XDmtea63Va9rNoHoACKXlIcytVE+dVxBcwwiPpA2ZcvOqnkC
         FvU2TIdh9Onjq56m77hXRMVA/ycJsSuaMsYOOc+hnuoJskr1RFA4Jql7/cdP4uEC6aIX
         Ov9g==
X-Gm-Message-State: AOAM530lCUw8Sc+yDRIkDsqVluO8JxP6rOyls2knZo6WufqElHvpN2Yd
        ffnYqwCj/cnpzRDp6K104+fo8a8Y2NHrBKnT1lqWQ5PM5+Bx00hAhz+11D6Gwt9Ju/jxc4D/9a2
        eT+JP7DrI6ZhVPO8/MIWT4E4i+pQpK1JJZ6yVOv8=
X-Received: by 2002:aa7:d295:0:b0:416:438e:d9c4 with SMTP id w21-20020aa7d295000000b00416438ed9c4mr25157409edq.98.1647340609086;
        Tue, 15 Mar 2022 03:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNAdezzJXlvUWpVXxB4T7w7pvN/7+3r1jrwVFjSzPbTqD5zxBdf5ZWDjZyxsdEDeC/bjygzg==
X-Received: by 2002:aa7:d295:0:b0:416:438e:d9c4 with SMTP id w21-20020aa7d295000000b00416438ed9c4mr25157391edq.98.1647340608923;
        Tue, 15 Mar 2022 03:36:48 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id o3-20020a17090637c300b006d8631b2935sm7869716ejc.186.2022.03.15.03.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 03:36:48 -0700 (PDT)
Message-ID: <bcda63b6-16cd-6514-42e7-fe09f5a5fb34@canonical.com>
Date:   Tue, 15 Mar 2022 11:36:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220315055504.27671-1-ctcchien@nuvoton.com>
 <20220315055504.27671-3-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220315055504.27671-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 15/03/2022 06:55, Medad CChien wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM memory controller.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
