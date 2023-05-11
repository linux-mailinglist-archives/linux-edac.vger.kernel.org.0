Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98206FF8A6
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbjEKRqa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjEKRq3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 13:46:29 -0400
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD471FF7
        for <linux-edac@vger.kernel.org>; Thu, 11 May 2023 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
        s=default; h=Content-Transfer-Encoding:Message-Id:Date:Subject:To:From:
        Content-Type:Reply-To:Sender; bh=wNPcqm3CvqUYA9urO3gw3uaGYUeofFj1Jg1f3fH9AwM=
        ; b=oaZ6HpfnxiKz0YEz9Lm/T8Ykp1+s+TKvdKx1f3K9hQEG/o0e0Li+GmKslWS2iy0FCPfXBtfVA
        TDAN+PKWLxvzLMw0QsZXojQgvOuSiqEUuQVfpXENbZjGDQmqw4AAsIzDmiW+6vyGwVBp+4R5zLqi6
        2zFhi25GipOqdtosw+q/fuHWG/A3tdVggfOBZ2cRwBtL+Kl3MqXBZJO8gdkHkmG2yWiHtRNoIS/L/
        aWttX6q3gfxg4rkXJ9LSJX0b76a/kjuPR88q3VmyD+EB/arMeTy0TpO4Jds7IWpF3lH1pdXMFZghQ
        LEIIm0QfJkC38QttIHsfQGfbd6AcjsMkpWTfCL5avAIgrQ3dMkfTXJOshAsN27l6xwQmmV/H2p9by
        pNd/cc2XbIMf+oWyfYLaPHVdUC+p9JhHM/HF/4ghqNUyysdpBxw0Xyd593bcUAYdvl0xwMAVgW5bL
        CcPkAIHnXdWP1D7U3cAThWwJPGEzmuivvIyNZGeDW3ZRxqvo4m6MzazDqJ8uRfT9yWf2qcKBH7a81
        EfRxCbkH9lOHCwLSuS8gsDd8fbNOApiVG3fJX5tQX4rpjfzMU6qHrZjfJuAXoJ9r/+QAEOPmhYzEP
        Er+H/YX314j/Earb/5lugZA9CytyZMQVeo67S+iuG/XVURcWDIoTiYIaXpu66lVShxv3Ze8=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
        by a1-bg02.venev.name with esmtps
        id 1pxAMv-003fhq-0K
        (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>);
        Thu, 11 May 2023 17:46:20 +0000
Received: from venev.name ([213.240.239.49])
        by pmx1.venev.name with ESMTPSA
        id Hlp3CuspXWQmWw0AdB6GMg
        (envelope-from <hristo@venev.name>); Thu, 11 May 2023 17:46:20 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Add support for ECC on family 19h model 60h-6Fh
Date:   Thu, 11 May 2023 20:45:06 +0300
Message-Id: <20230511174506.875153-1-hristo@venev.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
References: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I'll send the updated patch.

One thing I noticed is that in the ECC error I observed the address was
not decoded successfully. As I don't really have good test
infrastructure (getting the error involved tuning voltages over several
reboots), do you think you could look into it?

