Return-Path: <linux-edac+bounces-3378-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB5A6AB68
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CCC1897833
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98932253FD;
	Thu, 20 Mar 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gKotdTnf"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8D2248BE;
	Thu, 20 Mar 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489210; cv=fail; b=e/OH8IEOZopQVOHcCC74ylI8Hp1t2zJU7+9QKoS+FBTcfFV22h5lbM36XLYnhFGxB/ofDJaGM3NuoO9+kQme0suUGTYdpj+87FejORBhB7JQDb4FZROmDAoXjZI19eaDxdO+e1sdC2D1i7WzuGG2A5QqspYdv2Yw4vEw+nVnQ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489210; c=relaxed/simple;
	bh=TNmi3+YPYXwXiTI3l4CSs89tGxy6S6VJLgNeu5ejswQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HB+gmsiTiiglqlLhCF7MUHki4gAdF3K29kdYfQmNFJIGXf6CTh9iSkbzr3sECrNIkBJyxfhkrJEBSScbwitliSwkfySFK9uAL0Yq6li2S6cotRhAoG38EOUzNwNkkj8owBSpFdWJl8Y3+YUTHvDzjSvAnZoVFDZcyNjBuWqVQLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gKotdTnf; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5KS/xBV/5YUT3LGw+fepuxf7eTy9QoWIkUBGaAsq+EgSmIr6HMSd/xC0JL90TwvlG/dLpJobm9tsF2KGmW+SFXk5JpodQYsT3xrxk8j4u3HByn6KsCV0HTxDuobDWVWzDgPbA8BsHJQ54NuXeER7KTqdxx2BkJO2n4I3rBmTQkCxhPQPr3SNBr0O3PU09U5Yq6bJPzHodz5+DeBwiJEgL0uo1O3jUqwq1AarGm69sZGahszrzcWC7FPyLimUPthVJssNQn1hGFd0XEWbhiM0WUXmOcxyeqpNqAAQebb+k/adbYtNyl4fnIkR6+VxG3352BIz1WjLLXeMrWlxIRHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyADAeLx6TQYQmNRdg58XfIYQf0TPwa+gkHaWSqLmYk=;
 b=iJBaEqUB2MOIA452X/zLN/uyFd5R+EY+fPujLhoepCN0UA7jLwE1IiZrmKakb9Vl8PFG45QvIDD4StA9kRPD54Jqa23TMpmXDct3Txrso9nw/kA+flY9MhC2ogr/k4P7AjsMhqwlrSNtQnv6mML+zo40akvwmuD6udJYFZMybF8z5GycT0E5pwGnowCr0tyd1AokVYNkPbANEFxNVvkwkd6YDqzRBj/D5MHWfRx+4N2bS4feka3/zBrEwMcoJx7QorWmhYq9hbfomyy3uQ9lBTOCYKOt562fA1ZlTDxsjHH2uWZtbYZNMNn59/RNLdkN6DgqGPMncSzczE6a+Ri5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyADAeLx6TQYQmNRdg58XfIYQf0TPwa+gkHaWSqLmYk=;
 b=gKotdTnfhDNKpAFKU7XMpUfMts9Tzql+MafN0xNSLvxekgJJg88dJO5X3+OnkhZVfrHXcC7Lc5jltPFZ1FNcTtLDspQWU2MZQBzHzy5LKTjijCXjqpBT7A+RLKVDfULHChrzmPqMRbp0/OTCJU0gc11sqCLw2F8ODrYnPlPYiqDS+l2ibAjpal2NbC5veH5oIJ4ZH1EBN3R0GsmWuhhsADxhMrrpT+z8TvHW2ygYCBnhoGpucmM5Pl9YypXhXD2gPwHkzCqfa68+UgXb/am5s5toEiX0tO426AIvVxWf5nzuuHx1Tf1Kq6u/4efmXiGdgWT+LGQ455NY0CxmvxyVkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY5PR03MB5014.namprd03.prod.outlook.com (2603:10b6:a03:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:46:44 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:46:44 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 4/4] arm64: dts: startix10: Update eccmgr in DTSI/DTS to reflect hw/yaml
Date: Thu, 20 Mar 2025 09:46:22 -0700
Message-Id: <20250320164622.6971-5-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250320164622.6971-1-matthew.gerlach@altera.com>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY5PR03MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 9455b11a-ad1a-4a10-fa32-08dd67cecbf7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gR2Bgv3O7XCZa/H2FfRU2MPqCNh/kcyIJlYUSgLD/jtyMiufcqk/NVZ7qCQ?=
 =?us-ascii?Q?+1wQXmAy9EgCp3kVugOwIlnMQNBkfxsy37dy13UmjkfN8hARwgwX5Ead4AvT?=
 =?us-ascii?Q?uDj+iHLy1ShcInz4V/NhtgTAra0CZKPz8tfoiG+T/ofHFUfhgMdMnjCUylIg?=
 =?us-ascii?Q?lw+kgIj35deGHaxouZE7U+FTMrOfPAOCwLkc/hgFvcSDkuBkRdgmaZslH6kG?=
 =?us-ascii?Q?5LUsHWlQPCNjNKePXga5sbST1bD0d+rH3TkSEWMLHukRsdAzPL05cBosHKQ2?=
 =?us-ascii?Q?ngb7sPNGr3WYoO1aG3xidbzSWYUIpZHZJtbu3uEkvZX9qoyieGj0pdE2AW7E?=
 =?us-ascii?Q?E1JB2eje3IveqJACTiavHfsqzxCmqWuP2f3iAmylXqXeP0SIf+dwDz8hiRmN?=
 =?us-ascii?Q?Rfyhd59khNdw9pWm7onmY1FEeZrvnXBIwTiQshawfP+RIHlHc4EICNvTAgzr?=
 =?us-ascii?Q?zrEV6bMNpoKGNQQKnudDb1701otxjp9nzq/RlLcDF5DDbPUWcU2AZiUx22sW?=
 =?us-ascii?Q?JjvHJFpSoDjqyA8RxpZkkp/OyqLmDfwC64igUPgKodST5wh3HhsJ85m+Zbe/?=
 =?us-ascii?Q?OUzaRKPl0iRpnNpt5C0DhplV7YHkPUHChFacFgqTQfx6NcCxWerVOipY0dkK?=
 =?us-ascii?Q?RyE0Q4lZtmu9d4fy5fAoRZSu2niKKaV467YF8IdhcwKPR+oAc7wLlxSvba15?=
 =?us-ascii?Q?xRbRyjGpTEod1Exe735WpRuPisLXM1HFhJhHRV1Jy8qoqxkoUVI1cWkou9/d?=
 =?us-ascii?Q?WxisNMQKZlnQp1xuQXIowHUQPufFG0PPGIp0OKqvGsRI4ydVgUzGPui1waup?=
 =?us-ascii?Q?8ZRr6gfkYlFfV2FObJE0ELWOACOzRbgTh7sClxLKZXa6r6x4q6bTIO2s3A8D?=
 =?us-ascii?Q?VKRQnJQrQuRJtM3862cfjiXE//qfzIn+syyIlPmBL/GX8kQffRXDmjDHHEKn?=
 =?us-ascii?Q?APi4YQy01SB7dY4phBXXdbHwGAIH/xAMenP/ElfTbBvq4CMmsZ8E1kcQ9wa3?=
 =?us-ascii?Q?75CbyMNgGWz9fKXlIr18zyxUX0VNbkXZfjAC41quXQCkaGwe2jiLPRRrc+f0?=
 =?us-ascii?Q?h1snjpeaoNvpPhYfB7KhaMClAdN3kEkjd18LS0KPPxxgXbP17kbhK4ZzNxoi?=
 =?us-ascii?Q?CgZvTYKoUGeb/1GPUQSL4IRKgkb7h8GBJLP1VSyqtMRIm/vxUW5ZH4V7ovll?=
 =?us-ascii?Q?3Z96utH9jeHvLKqoMSuPDeum998zvziXmIkcDGZB107MZbWeB6bqDJeSc1Qw?=
 =?us-ascii?Q?nAGgNNoeri0eElKOJGbuNlB9O4PefcmeDtaye/LJvpFkPi7BnQAQ5x3mg9Sg?=
 =?us-ascii?Q?UFUzRJEepTsebnya16fWaUcsejnkubs6tsb7onSK93MCNuoi+WsUqqC2a4NQ?=
 =?us-ascii?Q?4V3X6nHSSFcWV8N7jIIYqoul5q/6dQ6Us8hmOePa3pkNWCANFCLCSjNMuVSv?=
 =?us-ascii?Q?2b+4w6QCPZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbLzOevTAA3iaBPetO9+M+kNrCOpb7rD6/yiE3fhVvnYMxRE+sQHbJxkSoBp?=
 =?us-ascii?Q?siJCDk+lCLIiXGJ1T+PcxkQFLEFtfyYgiOV3W6Z05ZGj05/ig62T1FCcELgM?=
 =?us-ascii?Q?tMJhRwD9A5yu+nhvU16D8bIYD7nsyC1pim1zxkxlATeChl5fB27RSRsv3vyP?=
 =?us-ascii?Q?C0hCX0xalPtbf9ZUwLlfUE9hab6WdCF3axE0VpbX1HCeMsl77ZzGsuoVG/0P?=
 =?us-ascii?Q?rXp2linoCj77m9QL9pjZoELMIPNzag3w0DqXtNb0eXrpE1s88xvICHkb1EQj?=
 =?us-ascii?Q?SkBN1LNBoZTQEWvLr+WRD+CSWg7U9h1tefBDyDYTfsmm+0+Dr/QaGRkWaaqW?=
 =?us-ascii?Q?RG9Wpm/CmP8PkoTzRnu7pMgUGWnAezqA7y+cFciVxDFs9+DhhgbVvGsvcPdV?=
 =?us-ascii?Q?bHFy4Q/cUdsxip4Ees7hvpRRvq/SHKEviT9O+t7m4xFTSTv9RfC18XwfzgJK?=
 =?us-ascii?Q?jn2M8wkRUiXwHF1q5uhB5J0HzL6cretGeWWQwbfDKP9lhqZVcX7KIPCgqZqX?=
 =?us-ascii?Q?7FjmsJtVD2BQLu03yOamsO2saVYdcPvzMSO3OE1cgJ/UDr+LbjQzPlmHrYlQ?=
 =?us-ascii?Q?eQvx54d5DTGaXN7u322YO638nXqGRfjK+uTg4pni4TeLus5gLOxYV2UUbp66?=
 =?us-ascii?Q?+T7LPweVh5ckrgZET94/ikhu9oh3NZI76VHU+Y3jqaJNtOSaOn7RAsieAcPD?=
 =?us-ascii?Q?L7pABojLpD94pSfP0CUYvX1qdiT1jx5TyrsXvKz9dg/E8jhOHHb1RXdc4ev7?=
 =?us-ascii?Q?h40SYu3tHzFzHxlC8xyrKX1/y5SFkueGHSID4UWzjo9UBG/rf7AHOeSceXpb?=
 =?us-ascii?Q?5NVJPe6pVNpVLU8AYH1wTBWVGxtwCWzLLoX5M3p63rnNVsaNDLxRUTpaDeKS?=
 =?us-ascii?Q?1k+rCDMsIQKQJtT8B5w5PFbNrA4PcgEH9J5Dh0ckJG8jLhUW9VAd6PXU1lpF?=
 =?us-ascii?Q?kU6orMQ0qsCpqF2FpqxMSPkWbTFRXZnhKt8CJllpA1W6z7cpqCV6hUZYLf39?=
 =?us-ascii?Q?pdF6sIeAWp7yUO6vWZkqEvvjuuv2hhuiY6dRUXTVu07X4QrEs0+NyfbaTU3r?=
 =?us-ascii?Q?lcq4XCR7Laf+FqPwRCcVMIJypsNwrlvaC/b4bzu4nIqAEEh/XIi5sHG09fno?=
 =?us-ascii?Q?gR6raKJbWtXKklOn/LDisPw0CY2yzyuFDe3k924d/bp1a/hzFydX+c22eOEV?=
 =?us-ascii?Q?+Ofhskw38vD00+oETKHjPiFjtz7a8B0ZP51kTo2RSYhlG3ivPqbXWlRUB7Ow?=
 =?us-ascii?Q?lbIRFoX8E47quDFDYIDokCQxVUw7tVOJWHV86igUuMYRRzhAa1R4AdskadIB?=
 =?us-ascii?Q?cwq/K7nTIRFWsAtlMM0s4YyufOzVR0lYKBMYuxbmhwPT5Am5xchPnt665IvN?=
 =?us-ascii?Q?Dv4KzH6TIPi0WKjS2zRVUksZtUTPgBjXMjiSx2kEjRI+rMKYNvDZttXsMlD+?=
 =?us-ascii?Q?EJIBi3tEotxGH1c+eAKKnmELNT9O3jmtvbvg+QNOufkXpkS97wDc4wt7/iyW?=
 =?us-ascii?Q?54mHtne5aS84teiUCogVChXdKhqxi3CmNi2H45hIcWNXwkiaDsjWp5iaub7M?=
 =?us-ascii?Q?iqKBFynQ/YRycS5OUT+qaDrfXvZh8sUM/8KnRvktYD6KzjUFrGTjxBjdjh6E?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9455b11a-ad1a-4a10-fa32-08dd67cecbf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:46:44.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhY9x2sCJMU+C5AveW/tkTh2QVzXygnzCvjHCBmOhHlL2yZAmkoEW8dCYGQPGkO+c3mPIDAE8nF16sQx9H3Wp0+w/2tvwmpFaQZLglBw/xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5014

Update socfpga_stratix10.dtsi and socfpga_stratix10_socdk.dts to track the
actual hardware description provided in altr,socfpga-s10-ecc-manager.yaml.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 15 +++++----------
 .../boot/dts/altera/socfpga_stratix10_socdk.dts   |  3 +--
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 0def0b0daaf7..647f4bb1e4a2 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -579,8 +579,7 @@ sdr: sdr@f8011100 {
 		};
 
 		eccmgr {
-			compatible = "altr,socfpga-s10-ecc-manager",
-				     "altr,socfpga-a10-ecc-manager";
+			compatible = "altr,socfpga-s10-ecc-manager";
 			altr,sysmgr-syscon = <&sysmgr>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -596,32 +595,28 @@ sdramedac {
 			};
 
 			ocram-ecc@ff8cc000 {
-				compatible = "altr,socfpga-s10-ocram-ecc",
-					     "altr,socfpga-a10-ocram-ecc";
+				compatible = "altr,socfpga-a10-ocram-ecc";
 				reg = <0xff8cc000 0x100>;
 				altr,ecc-parent = <&ocram>;
 				interrupts = <1 4>;
 			};
 
 			usb0-ecc@ff8c4000 {
-				compatible = "altr,socfpga-s10-usb-ecc",
-					     "altr,socfpga-usb-ecc";
+				compatible = "altr,socfpga-usb-ecc";
 				reg = <0xff8c4000 0x100>;
 				altr,ecc-parent = <&usb0>;
 				interrupts = <2 4>;
 			};
 
 			emac0-rx-ecc@ff8c0000 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0000 0x100>;
 				altr,ecc-parent = <&gmac0>;
 				interrupts = <4 4>;
 			};
 
 			emac0-tx-ecc@ff8c0400 {
-				compatible = "altr,socfpga-s10-eth-mac-ecc",
-					     "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0400 0x100>;
 				altr,ecc-parent = <&gmac0>;
 				interrupts = <5 4>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 4eee777ef1a1..06b91c7c0a45 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -54,8 +54,7 @@ ref_033v: regulator-v-ref {
 	soc@0 {
 		eccmgr {
 			sdmmca-ecc@ff8c8c00 {
-				compatible = "altr,socfpga-s10-sdmmc-ecc",
-					     "altr,socfpga-sdmmc-ecc";
+				compatible = "altr,socfpga-sdmmc-ecc";
 				reg = <0xff8c8c00 0x100>;
 				altr,ecc-parent = <&mmc>;
 				interrupts = <14 4>,
-- 
2.35.3


