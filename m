Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E3607BC8
	for <lists+linux-edac@lfdr.de>; Fri, 21 Oct 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJUQIX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Oct 2022 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiJUQIS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 21 Oct 2022 12:08:18 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (mail-bl0gcc02on2121.outbound.protection.outlook.com [40.107.89.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75B27EAF9
        for <linux-edac@vger.kernel.org>; Fri, 21 Oct 2022 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7pW7CRLZptVXHWrdwubb8lVwaqs7+WclvBPuYSHFxiozOG5S6lGT030tmElAW7iVC/WLJiKackbzuitBimQoAQ6J/1imPk/ok6r5wWUKCsiInzi+axpHMx2+wdXdfBiYBkm3g4Cl9Gg4U62tigLvgNVaN5jw2Rupb8s/sBQNrvsHzZcsS0RqOPQcRtqVb0XXzK98hp+eIJJWCGAzXyKRz+eGfKRAmj2ThMg/wl1Xprl7/QKSy8AsfagiXamvbhFRH8JWpZfxPEWeb2DiPM++AQNSlF4CFx2LYd7QcK0ObKY68wU7RcjunJeRI8jMQP7JQRkSy9coDZ7Gw9b9stqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TWJ04xfrTeM3RzSsgp5OrC5+4krprKIjhntFBrvhdw=;
 b=MF8FECBN0RGxO+arxLU1FJ78zFB0eUc1i2tA2y5iEhPBSKphswUIDTe6k8Vu5NdQZS17C5ydoLC+z/lJz/3DH/3LfvqOVtESEKwgKA7IIdMd0QAktJvNejhHG6Mb+0rIPV9AbOIAYjP4nt3Vvjbh0qpLY7TAN9BDsamfVMpUFOyjpcbBYJyABFRV/hfPA/araSC5XfrwOo7F37VFbJvXYxYwBj2rAalf77wKz5GrISjeuYBUCZZpXm/uUkXkPWKY7Iyzs2RHmtUtQZ8Kx/Km96yCubKPYtmaqZa0LbEjYIEBNR6R6w1UkpX4Vv7R4u+F0fT2MsZFQb8RiXWQJrSnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TWJ04xfrTeM3RzSsgp5OrC5+4krprKIjhntFBrvhdw=;
 b=oZsR1tghvsbjEJgwYMaDSKeu3s8KoJVtiXWxEClcQJv+wQmsVvOMpX2Wcg8VElnJmTqBDzeP7yMi8GCCP4AGhKJqlcUmq5t4wgBWaBxvf4Nt/Jw9QPGOZiTeE/LCA3tYLK+V34QlQ2AbeILGUhXdUsVDWXRW1JrnoTER3CVu6MOwnb7f2J40JSe7oy0GXoqX8I8TP4L3Yg8g/D+U3Mnd4OLx2+9WTfs21axbKrEXKN7FPuE1OXGcUJ7Ag3OKk53JgAqs5j68yvgwajSsFmtoTL/U9n/tnOaDHIsJB85Itd/DqMJWpY/EmmC3QqygrSbtg8fbGgdBCfyJtFYgbr5Keg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by PH0PR09MB7769.namprd09.prod.outlook.com (2603:10b6:510:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 16:08:13 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6%5]) with mapi id 15.20.5709.015; Fri, 21 Oct 2022
 16:08:13 +0000
Message-ID: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
Date:   Fri, 21 Oct 2022 10:08:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
From:   Orion Poplawski <orion@nwra.com>
Subject: EDAC igen6 error messages at boot
Organization: NWRA
To:     linux-edac@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060403030602030008030907"
X-ClientProxiedBy: CY5PR15CA0205.namprd15.prod.outlook.com
 (2603:10b6:930:82::23) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|PH0PR09MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 228bfd1f-910d-4ed1-45c9-08dab37e74cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5AeiBgo6L4vF3Y2B3DG2GKSKxz8caBpoBHU2FyJi+jFw+qNuB5SO0A/Vd2DWRvVUU7ICF9WNvLMUZk+nHxGwfDTUla/P2A9syhw6sBjlX6M69oMDHMNBGQlABV3XLHssvVwrXPFgFJGcvZGn1YsAtkrKss5RaHPRAEIoItjymLSOLY2rawWTin2Rp3GX3csi/FOuMeTatxm2D7YE6jD768PUjYYR9mBsx4OdpoVk2TjoJP6ND3Qm//5fnV+I06ErmHFD2LdC0bi7REMyvAoQxtpZPHIGR3qWVjeet6c45iEEmJTd24M7DPsZbW7SxYnPBR/gKJ2T+AThTaZ++cX4Lh+AA5eL+fIWuu5BL0tQUa01QZVkdu0QO/U8oYy4S7h4ZkgUux8K5enmkx3uGZ6vSbJLn93o8AEiVVQhsPjSJk3k9cbvtdIfTbiGfP8LBzk2uaiGwdauXBwEzb8tXuDJIzEv2KSHSWZnLMvjrZxlmMnsnx1PZPKEdwvyqQD43d63AwkKxbNxHQOel3OxUYDQuqONkOICzu1fsF/zOlfOGIP0+6zBIDnpV4Zqz9d0F7QyaiAEjBBlapeS24kb12RPAQpToUhu320tgU34ATbkgkECe4qk0rmZPiFwLO5JZKru0iurY2XD1PmuG3Nv/FVQd1nLF6nmg4ENLCLvRQKypikIWVGNvdrS2fcCF3VRFuAb14Qd138guenAstMtcstxCVxzDMajSr2/tgRZnWpSTYpG1VDQM8es48onD5GuiV5biTOuz4FHq5Q8Lzs/lq8Qo+xDYw1dSWjcTupE3HbCVtpLVpjRwtQcDwqr7/Dba5ReWEoJseID02Tt22+Jo9TfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39830400003)(451199015)(2906002)(41300700001)(15650500001)(66556008)(66476007)(5660300002)(66946007)(31686004)(235185007)(8676002)(6916009)(36756003)(33964004)(6506007)(6486002)(38100700002)(40140700001)(508600001)(36916002)(26005)(6512007)(966005)(186003)(83380400001)(8936002)(41320700001)(31696002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2wrREZoZFBJeksySnZOdE05eDZmNFg4aE03WCtWcXIxekZFV2JOdHhqVGQ0?=
 =?utf-8?B?SytiNjRjOWt3SVN2VkFxV3YwcFp6V29PMmJNQjJxMm4vcHJWOUIrOUxOK242?=
 =?utf-8?B?YjlvZ3RiK1M2dDBiSHRubURQdytRZ29rclViQ2R5TVFLYjRUbWZYU3UxV1Y4?=
 =?utf-8?B?QXdXOTFKNVlGdWt6MWU0R2JuMjhITHA0VWZITWtFeGpEUUxuR3Q2aENPejUw?=
 =?utf-8?B?VDMzdm43QVlEc0JHNlRBeHJvak5CRUg0dk83WEM2K09NTDUrK2xOSmxjSGhV?=
 =?utf-8?B?UTlVS0FvNkpGRDZkYnF4MDlUU09paWwreWpqNy9nQmxTZTdJdzNCemJ0cUxp?=
 =?utf-8?B?YnduSDlCc0J3cWIrLzBzVi8xV3FKenFqL3Z6VkxUR2llMHREbUl3czlwMTgy?=
 =?utf-8?B?NkhqSkRkZHJ4dlhQbCtXSVdpak5xS2FSbkpvKzVkeFBWRGszbFBTSy9tcjJz?=
 =?utf-8?B?dGRqTVpmT1RWV2xQS3FXQzd4aWNXOVlhd2FwUnVJckh3YWx5RHg3UUxyS2k4?=
 =?utf-8?B?MEpSeVRKTVpydUZsWnNWcERONFVFL1VmMVhBOXIvU3JuSHVzK2RWUVhSREpu?=
 =?utf-8?B?VW13RFJDck1LQmZObzRYS2pMbTJrSE5oTy9pOUhYdE9PRFhuQ09BRHdIaTJo?=
 =?utf-8?B?V3ZFUDZGWnBsNzh1djRVTERaNlZLUVEyQTVKd0lCNTFQYmRKY3phOXlNTHc3?=
 =?utf-8?B?RHVYajJFd2EzS0FVKzdjL3NEMlgvMjViVlZVTTB5UGsyZXNyNVBIU2lBSUU4?=
 =?utf-8?B?bDJ5VTlDMklxZU1rT1o0L2FaNElQZXNreS9QZng4RnVrNXhzWGEzcEZ6c0Qx?=
 =?utf-8?B?K1FQTnVqa1pRMTNWVWs2Q0JXY1pnVTZYSGRLM1Qvb29GMkxuMHlEbEloY0E0?=
 =?utf-8?B?blh3UmRXd0hBSWVneW11dkFBanN2WFhjU1BRa2JDSVJlNlBzNi90N2V3Ui8v?=
 =?utf-8?B?VzVXalJTWlhKWFpIWFFXTS9ib29LS3FVckVvZ1FGQnp0ZktKN3VEcE0wZ2xt?=
 =?utf-8?B?NXhScUtFS2Y1UkdXblZMSUZza2dSMUhSc0J0MFpkOGUyQXdJdkdLcXZIcGQw?=
 =?utf-8?B?Z29Icy84M3dwK3RxTmU4RHlabGxYbklzOENSUkJjcU1ZeWptc0ltTkFrOEh1?=
 =?utf-8?B?TUYyamhYWU44YXAweVo3NnFkdkxXMzAvdUFMTThLOVB0UXdhQkhIQitGNTdM?=
 =?utf-8?B?ZkFGSndxQTV1VWE0UktyMzBOczVBaVpBc1JxMTYrY1FBbEVDYURGbk5SM3Y1?=
 =?utf-8?B?QVB1UWJON2xGWkF6akwrSGpPYktOeENSR0Y5dE9EZEJhVUNMMU9Ja3hPVXJY?=
 =?utf-8?B?cmJhbjZDa3QyRElOeiszVTFNTGRZT004aHRmN1I3N0NTOTd0Z2laRnhLVFVv?=
 =?utf-8?B?aE8zejlZVHIvbE9IVWVicS85OVR1VS9zOXBPNU1yempjcndJRnBaOVVTQ1V5?=
 =?utf-8?B?L0paVndOZ0dZdWd5aUp1S1phNmxTOEZmajk1Uml2YXE2Z1RYbVllRzVUS1cr?=
 =?utf-8?B?L05oMXp0WDkyTFBsMEloTWZGVi90Q3N4VFk3a0t3d2hnRmp3a1d6blFpWjZL?=
 =?utf-8?B?M2ltcmk3aE91U1JrTVBVckJWaEpqQUZmc1pqbFVqdHBhOE5XQlc0TlRGMk5J?=
 =?utf-8?B?YVUySi9oWXJPSGJUWXk1ZU1LMW5CL0RVOHVxblpoNjJ3U1RaZ0ZIMUZHbU0r?=
 =?utf-8?B?RVFSNkhab1o0YTkrREhZRnNZenBLZThPK01JL1JXWThOa0FjLytrQ3lzWWhu?=
 =?utf-8?B?ays2WFF6bEFGOFZLTEI5ajNPbU5rRDBVb2p5UXRJOUM5WHg2aG44bGVaRzhY?=
 =?utf-8?B?RzJndnE3ZEZlazBGa3B4WE1yU0ova0RCMUJnMUR5WVhsR2djRW5nSVRicG45?=
 =?utf-8?B?djY0N20ycFNWcGFreFQzSWRVZjVvYWwwSmd4MkpkNDBCN0lGV1FvTk9WTGFp?=
 =?utf-8?B?azBvcmxCYTZLYS9CVE84RHNuSXFIRUo5WFRHVCsyWFJsV2xzanMxKzdoQlNY?=
 =?utf-8?B?T0FqUTBwMVNIU3d1bDlQakhnaUl2azROWkdFRnZ4MU5lSUJGWC8rSzZBTjhu?=
 =?utf-8?B?TXpFdUd0TVRzZHlsZEpDV1d0V1NDRHg1NnNVQjFsMytlazNIUjdWK2ZhZlBj?=
 =?utf-8?Q?c5V21HguPW6V4E4Ji6blC0Enr?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228bfd1f-910d-4ed1-45c9-08dab37e74cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 16:08:13.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB7769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--------------ms060403030602030008030907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have a Dell XPS 15 9520 running 5.15.0-52-generic (Ubuntu 20.04) and get
the following at boot:

[    0.981641] EDAC MC: Ver: 3.0.0
[   31.801126] caller igen6_probe+0x176/0x7b0 [igen6_edac] mapping multiple BARs
[   31.805272] EDAC MC0: Giving out device to module igen6_edac controller
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[   31.810599] EDAC MC1: Giving out device to module igen6_edac controller
Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[   31.810616] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[   31.810617] EDAC igen6 MC1: ADDR 0x7fffffffe0
[   31.810619] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   31.810620] EDAC igen6 MC0: ADDR 0x7fffffffe0
[   31.811957] EDAC igen6: v2.5

logwatch triggers on the ERROR and reports them.

However, from some searching around this seems to be fairly common, so I'm
guessing they are somewhat spurious.  Unfortunately the messages seem to be
similar to what you would see with an actual memory error so don't want to
completely ignore them.

Could anyone shed some more light here?

Thanks!

-- 
Orion Poplawski
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms060403030602030008030907
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CmMwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggVGMIIELqADAgECAhEAyiICIp1F+xAAAAAATDn2WDANBgkqhkiG9w0B
AQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsT
MHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0G
A1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAy
IENsaWVudCBDQTAeFw0yMDEyMTQyMDQzMDlaFw0yMzEyMTUyMTEzMDhaMIGTMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEmMCQGA1UEChMd
Tm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9uIFBvcGxhd3Nr
aTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAxBJrIv9eGtrQLaU9pIGsIGBTiW0vZIYmz+5Eoa69sj6t6QANvg0IuVgWZajH
2fu8R+7m/AbZ8Wsuzz+ovtDHiVqUGvGzYyN9a5Ssx94SwNp9zLPfdCRMdh3zJB7gc4GYE/fA
kMkieO8u05f/hSyf9zU5gpjl7SW6p8IjkoyxNOr7KCbI4CQ3+1LG8pn6tz/QJwQ/BJZa4dE0
asXfNlZf5kZtyWtJhwub76zH5uXeODDxY3RooWj1l4V2fQCoFX2ov1ENUW4hRov1cMAD2QHJ
KL0Boir36wISvzq8Z65MSMCGNRiWwRaclVwVZ+QYnlhGZ0g6tMvxVrK+sHnxxr/LOwIDAQAB
o4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cu
ZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0
OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5u
ZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaA
FAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSpChQTknhqMfb9Exia9G14q4j9ZzAJ
BgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQA15stihwBRGI8nFvZZalsmOHR954D+vrOZ
7cC0kl9K+S9u8j/E5nZd+A6PTKoDpAEYmPUYpe45tZLblnvfJC0yovSIIMTo1z3mRzldHYAt
ttjShH+M6s3xrqDtHfNAwt3TCf6H83sEpBi6wtbALfkIjKuDitgkdZsyUURoeglaaqVRhi2L
5wOOChQAyfsumjT1Gzk9qRtiv8aXzWiLeVKhzRO7a6o0jSdg1skyYKx3SPbIU4po/aT2Ph7V
niN0oqJHI11Fg6BfAey12aj5Uy96ztotiZRQuhWZPOc4d3df2N8RsdWViBp4jXt2hQjNr0Kw
pUPWRO/PENBVS1Uo1oXfMYIEYjCCBF4CAQEwgbswgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
Ew1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29y
cG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4x
IjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7EAAAAABMOfZY
MA0GCWCGSAFlAwQCAQUAoIICdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMjEwMjExNjA4MTBaMC8GCSqGSIb3DQEJBDEiBCBQMG89foksQ3FL6kJZSxoA
DZJnORsmC5qAa67Ah/ak6DBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEAeXzvNrCci1qVxdOCAdkouiIjdrYjr6QdAdnxOPL47bFd
X4Pjpy8cnibh5wm6clykEDW5W2bGOyvk4ryuji5gk1gZaZ0EIut3qt1EGElA5kBTivTCMsst
bF5ZHxowTt0mo6/eTXD7MmPL4arv3vpNuaCifVgoCp9j1WHygwl8a+fIpxJeempmZjduqkHT
wSdzNm6o1BHZcJvbfgsVtZIqAXl4r3LDhxoCtGY0q7roPyOhCC1m8i3jTGlx4ilLk+2V0Uup
z5g7aEt/AZ8hiP2Vzjw8QpFieVvUQHpsywKN3XgIkvrO7KElrX+7AJEJJOxoF1g8lo9ciWdh
0Xa0dMReiQAAAAAAAA==

--------------ms060403030602030008030907--
