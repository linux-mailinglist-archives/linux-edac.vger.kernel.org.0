Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820DE2B7493
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 04:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKRDMW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Nov 2020 22:12:22 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:45585 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKRDMV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Nov 2020 22:12:21 -0500
X-AuditID: 0a580157-b25ff70000003991-f7-5fb48d8826ba
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id BD.F7.14737.88D84BF5; Wed, 18 Nov 2020 10:57:12 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 18 Nov
 2020 11:12:14 +0800
Date:   Wed, 18 Nov 2020 11:12:14 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     James Morse <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <CHENGUOMIN@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH] Dump cper error table in mce_panic
Message-ID: <20201118111140.0c330108@aili-OptiPlex-7020>
In-Reply-To: <112d8a04-4f0d-6705-4da1-e8d95a14dbaf@arm.com>
References: <20201104065057.40442-1-yaoaili126@163.com>
 <112d8a04-4f0d-6705-4da1-e8d95a14dbaf@arm.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXCFcGooNvRuyXe4Ns2bYvPG/6xWdzft5zJ
        YufDt2wWy/f1M1pcONXAZHHm9CVWizcX7rE4sHt8b+1j8Vgzbw2jx+I9L5k8Nq3qZPPYcrWd
        xePzJrkAtigum5TUnMyy1CJ9uwSujKszV7EX/OeueL9VvoHxAmcXIyeHhICJxNyu36xdjFwc
        QgLTmSTa1q9ggXBeMEpcaOxiBKliEVCV2PTsHDuIzQZk77o3ixXEFgGyL72cwQxiMwvcY5S4
        tSMVxBYWMJdYOm8FG4jNK2AhceT+DSYQm1PAWmLh258sILaQQIbEybdTgXo5OPgFxCReNRhD
        HGQv8fzvWWaIVkGJkzOfsECM15E4seoY1Cp5ie1v5zBDjFGUOLzkFztEr5LEke4ZbBB2rMSy
        ea9YJzAKz0IyahaSUbOQjFrAyLyKkaU4N91wEyMkJsJ3MM5r+qh3iJGJg/EQowQHs5IIr4vJ
        xngh3pTEyqrUovz4otKc1OJDjNIcLErivOlzN8cLCaQnlqRmp6YWpBbBZJk4OKUamDhjm2+V
        CLGK1ybO90vpvZHK/Jv3tDWv1veX1Z+UTTd/X7I7PUxO5o2kw4/MvmiLI1cPP9a/+Mr07433
        jsWzrmrPNgz6+obzI5/e/EkXzs+5OE0s86OoX2/ya5dM7j2P9j19/aYxv9/rq//7CY3S9itO
        bhQ1iBI+dJjzaOecJp27Lz9Udp2tcF4ivO5I4uObay1CvY9qasinM36IU//904JPQb7KZblq
        eMmjtQ3Kv0/cfaBs+nfe3WeWMSxPQs/byedMfnNawnPHzj+xm2ITT6+U5ghyXHPsH8eJRcsi
        P1w5nmPMt4T50P5T+w/wPwjYsqr1Wsd5vyVeh2dbGhxIk6u2v13QdvLpqtYi6ybVVfeVWIoz
        Eg21mIuKEwHBq6pB+AIAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, Thanks for your comments!

On Fri, 6 Nov 2020 19:35:32 +0000
James Morse <james.morse@arm.com> wrote:

> You appear to have something that behaves as GHES-ASSIST. Can you post the decompiled dump
> of your HEST table? (decompiled, no binaries!) If its large, you can post it to me off
> list and I'll copy the relevant bits here...
> 
I think we we can reach a consensus, from and follow Intel Document #563361 23.1 :
Feature Name MCA 2.0 Recovery (as per EMCA Gen2 architecture)
Feature Description
Software layer assisted recovery from uncorrected data errors as defined by the EMCA Gen2
specification. EMCA Gen2 is a capability that allows firmware to intercept errors triggered via Machine
Check Architecture (corrected and uncorrected errors) enabling a Firmware First Model (FFM) of error
handling and possible recovery.
Use Case
Enhanced error reporting to support Firmware First Model (FFM) with following attributes:
1. Allows the SMM code to intercept the MCE/CMCI.
2. Allows the SMM code to write the MCA Status/Add/Misc registers.
3. Allows the SMM code to generate MCEs.
4. Allows the DSM based pointer for enhanced error logs.
5. Additional IA32_MCG_CAP bit for eMCA support

> 
> If and only if those GHES are marked as GHES_ASSIST.
> 
> If they are not, then you have a fully fledged firwmare-first system.
> 

Yeah, This should be GHES_ASSIST, But For x86, BIOS don't supply a hest table for it as BIOS will trigger
MCE, It's out of APEI scope. 


-- 
Best Regards!

Aili Yao
