Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A57D6143
	for <lists+linux-edac@lfdr.de>; Wed, 25 Oct 2023 07:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYFo7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Oct 2023 01:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYFo7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Oct 2023 01:44:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A0912A
        for <linux-edac@vger.kernel.org>; Tue, 24 Oct 2023 22:44:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32003aae100so248856f8f.0
        for <linux-edac@vger.kernel.org>; Tue, 24 Oct 2023 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698212695; x=1698817495; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mlxm3NPH6VsoIn/MgI2GDEX33zkfPs2C3PfGFTSw+4o=;
        b=xLDo/BEcFtH4S72/rfQIFVHnt3nmxY4IGlYqzOVq9CCik+Ppzw3wf5Udaoa3IKOzDE
         220QIhPwMCWRbbkSFJaNKjecssobkU3IC+O+UjZQxjD8nk5uPqNVqAMEX4VegdGYSO1R
         pwd/jMN22TR/oxVwJGls3SBO6nnnF1s/EZFHK9cvaVqvGMJUHwYqJRXDxljia+86snMN
         EhYkkgTytOpAfw9afn/irKNfysPEhqCyL0M5WsCpOmE/lnphB98BnUy3tAjHNyAWBlvy
         pMVwu0EemTyRzv4jH9M4+pgn5ImnEsVV30MNjiD98qq1uvZw/25gih0sYdafnkvGyird
         UfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698212695; x=1698817495;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mlxm3NPH6VsoIn/MgI2GDEX33zkfPs2C3PfGFTSw+4o=;
        b=qpJhgRTPEJFy20WuXHX7+uk44gZxTWvtH5up0F6QuEi85wkjP4kWnO9YmbOXIcBVhY
         qJlLe9QTBroA/XNst1hknNizRdkjItVxRUBl8xf1Fk2AjArqSUXFUoU9In9kksoqrGwF
         oPwt905biOTJNeyAfgDCe1AZyGOKavz5dQ4UTFTmT3SF5mD2ti+e9I0JlFS+0X67bt8W
         4IrrTY+OUVwMVrQg9iTnvc8hUNfJgTqb9H4NA25/cRJjyVPLXoo3xuiLANDQoHzh6TQ+
         P7C6ySHHLefzUNwRrn1i67XjhshOA2q28dyjA11WPZKScouUCrCdWmO3E3oNL3I085oQ
         l8yg==
X-Gm-Message-State: AOJu0YyoDR76SiLHwcR7Hp+Egrei5yx1pbgLmxKdFv0KQMLAE6c2Aq3V
        LvUNjl8VLMQbMnNNnMLQY4vmlA==
X-Google-Smtp-Source: AGHT+IGCYMeJdKp45GJr6g7FH+tCuzzTnkfFs0HBmOJlF5OA+huufYawB9Hm/zpTgjYwXCDHwbbTXg==
X-Received: by 2002:adf:c041:0:b0:31f:fc9a:a03 with SMTP id c1-20020adfc041000000b0031ffc9a0a03mr14982864wrf.20.1698212695502;
        Tue, 24 Oct 2023 22:44:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q6-20020adfb186000000b0032326908972sm11390013wra.17.2023.10.24.22.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:44:55 -0700 (PDT)
Date:   Wed, 25 Oct 2023 08:44:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     zhiquan1.li@intel.com
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] x86/mce: Mark fatal MCE's page as poison to avoid panic
 in the kdump kernel
Message-ID: <12eb6db6-bc24-4e7c-af34-a5c68d49d52a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Zhiquan Li,

The patch 1d11b153d23b: "x86/mce: Mark fatal MCE's page as poison to
avoid panic in the kdump kernel" from Oct 23, 2023 (linux-next),
leads to the following Smatch static checker warning:

	arch/x86/kernel/cpu/mce/core.c:299 mce_panic()
	error: we previously assumed 'final' could be null (see line 281)

arch/x86/kernel/cpu/mce/core.c
    270         /* Now print uncorrected but with the final one last */
    271         llist_for_each_entry(l, pending, llnode) {
    272                 struct mce *m = &l->mce;
    273                 if (!(m->status & MCI_STATUS_UC))
    274                         continue;
    275                 if (!final || mce_cmp(m, final)) {
    276                         print_mce(m);
    277                         if (!apei_err)
    278                                 apei_err = apei_write_mce(m);
    279                 }
    280         }
    281         if (final) {
                    ^^^^^
This assumes final can be NULL

    282                 print_mce(final);
    283                 if (!apei_err)
    284                         apei_err = apei_write_mce(final);
    285         }
    286         if (exp)
    287                 pr_emerg(HW_ERR "Machine check: %s\n", exp);
    288         if (!fake_panic) {
    289                 if (panic_timeout == 0)
    290                         panic_timeout = mca_cfg.panic_timeout;
    291 
    292                 /*
    293                  * Kdump skips the poisoned page in order to avoid
    294                  * touching the error bits again. Poison the page even
    295                  * if the error is fatal and the machine is about to
    296                  * panic.
    297                  */
    298                 if (kexec_crash_loaded()) {
--> 299                         p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
                                                       ^^^^^^^^^^^
Unchecked dereference

    300                         if (final && (final->status & MCI_STATUS_ADDRV) && p)
                                    ^^^^^
Checked too late

    301                                 SetPageHWPoison(p);
    302                 }
    303                 panic(msg);
    304         } else
    305                 pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
    306 
    307 out:
    308         instrumentation_end();
    309 }

regards,
dan carpenter
